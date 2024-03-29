import 'dart:io';

import 'package:dio/dio.dart' as dio_lib;
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../controller/pref_controller.dart';
import '../exception/exception.dart';
import '../model/server_model.dart';
import '../util/commons.dart';
import '../util/constants.dart';
import '../util/customs.dart';
import 'response/response_refreshtoken.dart';

extension ErrorMsgExtension on String {
  /// uniqueTag utk membedakan error yang mana jika long error, biasanya berupa tanda seru
  /// utk memudahkan maintenance
  String toSimplifyMessage(int? errorCode, [String uniqueTag = '']) {
    if (length > 150) {
      log('long error $this');
      return '($errorCode) Something went wrong $uniqueTag';
    }
    return this;
  }
}

class BaseApi extends GetxController {
  static var apiKey = '${dotenv.env['TOKEN']}';
  final keyAuthorization = 'Authorization';
  final keyApiKey = 'ApiKey';
  final timeoutSeconds = 60;

  static Future<Uri> getSelectedUri(String path) async {
    var server = await PrefController.instance.lastSelectedServer;
    return Uri.parse('${server!.toAddress()}$path');
  }

  /// use Dio to upload/download pictures
  Future<dio_lib.Dio> initDio({Server? server, String? token}) async {
    server ??= await PrefController.instance.lastSelectedServer;
    var dio = dio_lib.Dio()
      ..options.connectTimeout = Duration(seconds: timeoutSeconds)
      ..options.receiveTimeout = const Duration(seconds: 15)
      ..options.headers[keyAuthorization] = 'Bearer ${token ?? await PrefController.instance.accessToken}'
      ..options.headers[keyApiKey] = apiKey;

    var clientPEM = await clientLogic?.sslCertificatePem;
    if (dio.httpClientAdapter is IOHttpClientAdapter) {
      bool useSSLPinning = server!.sslPinning ?? false;
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
        if (useSSLPinning && clientPEM != null) {
          final sc = SecurityContext();
          sc.setTrustedCertificatesBytes(clientPEM.buffer.asUint8List());
          return HttpClient(context: sc);
        } else {
          client.badCertificateCallback = (cert, host, port) => true;
          if (server!.proxyIp != null) {
            client.findProxy = (uri) =>
                'PROXY ${server!.proxyIp}:${server.proxyPort}'; // berhasil intercept by burp suite. selain itu mereka paka nexus. kalau HttpToolKit blm pernah dengar.
          }
          return null;
        }
      };
    } else {
      // (dio.httpClientAdapter as BrowserHttpClientAdapter).onHttpClientCreate =
      //     (client) {
      //   client.badCertificateCallback =
      //       (X509Certificate cert, String host, int port) {
      //     /* see https://pub.dev/packages/dio  format of certificate must be PEM or PKCS12.
      //   if (cert.pem == PEM) {
      //     // Verify the certificate
      //     return true;
      //   }
      //   return false;
      //   */
      //     return true;
      //   };
      // };
    }
    return dio;
  }

// simplify error message from server
  handleError(error, String url) {
    if (error is dio_lib.DioException) {
      if (error.type == dio_lib.DioExceptionType.connectionTimeout ||
          error.type == dio_lib.DioExceptionType.sendTimeout ||
          error.type == dio_lib.DioExceptionType.receiveTimeout) {
        throw Exception('Timeout ! Check your connection.${kReleaseMode ? '' : '\n$url'}');
      }
      int? errCode = error.response?.statusCode;
      if (error.type == dio_lib.DioExceptionType.badResponse) {
        log('error ($errCode) -> ${error.error} @ $url');
        if (errCode == 403) {
          // biasanya krn token tidak ada atau ditolak
          AuthController.instance.logout();
          throw CodeException('Session Timeout. please relogin', errCode);
        }

        if (errCode == 307) {
          throw PasswordChangeException('Password Change Required');
        }

        if (error.response?.data is String) {
          var msg = Utility.isEmpty(error.response?.data) ? '${error.error}' : '${error.response?.data}';
          throw CodeException(msg.toSimplifyMessage(errCode, '!'), errCode);
        }
        if (error.response?.data is Map) {
          var msg = '${error.response?.data['error']}${kReleaseMode ? '' : '\n$url'}';
          throw CodeException(msg.toSimplifyMessage(errCode, '!!'), errCode);
        }
      }
      // if (error.type == dio_lib.DioErrorType.badResponse && (error.response?.data is String)) {
      //   log('${error.error} @ $url');
      //   if (error.response?.statusCode == 403) {
      //     // biasanya krn token tidak ada atau ditolak
      //     AuthController.instance.logout();
      //     throw Exception('Session Timeout. please relogin');
      //   } else if (error.response?.statusCode == 307) {
      //     throw PasswordChangeException('Password Change Required');
      //     // } else if (error.response?.statusCode == 429) {
      //     //   throw Exception('Server is busy. Try again later.');
      //   } else {
      //     var msg = Utility.isEmpty(error.response?.data) ? '${error.error}' : '${error.response?.data}';
      //     if (msg.length > 150) {
      //       log('throw error $msg');
      //       msg = '>${error.response?.statusCode} Something is wrong';
      //     }
      //     throw Exception(msg);
      //   }
      // }
    }
    var serverMessage = error.response?.data['message'];
    log('data[message] = $serverMessage [$url]');
    // error.error.message may contain 'Connection refused' message, when gateway is down
    var msg = '${error.message ?? error.error.message}${kReleaseMode ? '' : '\n$url'}';
    throw CodeException(msg.toSimplifyMessage(error.response?.statusCode, '!!!'), error.response?.statusCode);
  }

  // 2 days built
  // sudah pasti menggunakan selectedServerByUser
  handleInterceptor4Jwt(dio_lib.DioException e, dio_lib.ErrorInterceptorHandler handler, [Server? server]) async {
    log('******************* Intercept statusCode = ${e.response?.statusCode} ${e.response == null ? ', Offline ?' : ''}');
    // coba request lagi utk refresh token dgn menggunakan token kedua(refreshToken yg didpt waktu login)
    // refreshToken umurnya lebih lama dan hanya dipakai di kondisi seperti ini
    //https://stackoverflow.com/questions/56740793/using-interceptor-in-dio-for-flutter-to-refresh-token#63219269
    // kalau masih return 403 ya brarti bener2 expired
    if (e.response?.statusCode != 403) return handler.reject(e);
    server ??= await PrefController.instance.lastSelectedServer;
    var dio = await initDio(server: server, token: await PrefController.instance.refreshToken);
    await dio.get('${server!.toAddress()}${Constants.uriTokenRefresh}', queryParameters: {
      'user': AuthController.instance.loggedUser!.userId,
    }).then((v) async {
      if (v.statusCode == 200) {
        //get new tokens ...
        var obj = ResponseRefreshToken.fromMap(v.data);
        log("access token $obj");
        await PrefController.instance.setAccessToken(obj.accessToken);
        await PrefController.instance.setRefreshToken(obj.refreshToken);
        // create request with new token. e.requestOptions contain previous configuration
        e.requestOptions.headers[keyAuthorization] = 'Bearer ${obj.accessToken}';
        // https://github.com/flutterchina/dio/issues/482
        // if (e.requestOptions.data is FormData) {
        //   // https://github.com/flutterchina/dio/issues/482
        //   FormData formData = FormData();
        //   formData.fields.addAll(e.requestOptions.data.fields);
        //   for (MapEntry mapFile in e.requestOptions.data.files) {
        //     formData.files.add(MapEntry(
        //         mapFile.key,
        //         MultipartFileExtended.fromFileSync(mapFile.value.filePath,
        //             filename: mapFile.value.filename)));
        //   }
        //   e.requestOptions.data = formData;
        // }

        final cloneReq = await dio.request(e.requestOptions.path,
            options: dio_lib.Options(method: e.requestOptions.method, headers: e.requestOptions.headers),
            data: e.requestOptions.data,
            queryParameters: e.requestOptions.queryParameters);
        return handler.resolve(cloneReq);
      }
      return handler.next(e);
    }).onError((dio_lib.DioException error, stackTrace) => handler.reject(error));
  }

  Future get(String uri, {Map<String, dynamic>? q, Server? server}) async {
    server ??= await PrefController.instance.lastSelectedServer;
    var path = '${server!.toAddress()}$uri';
    log('Getting to $path');
    var dio = await initDio(server: server);
    dio.interceptors
        .add(dio_lib.InterceptorsWrapper(onError: (e, handler) => handleInterceptor4Jwt(e, handler, server)));
    var resp = await dio.get(path, queryParameters: q).catchError((e) => handleError(e, path));
    PrefController.instance.setLastServerCheck();
    return resp.data;
  }

  Future post(String uri, {data, Map<String, dynamic>? q, Server? server}) async {
    server ??= await PrefController.instance.lastSelectedServer;
    var path = '${server!.toAddress()}$uri';
    log('Posting to $path');
    var dio = await initDio(server: server);
    dio.interceptors
        .add(dio_lib.InterceptorsWrapper(onError: (e, handler) => handleInterceptor4Jwt(e, handler, server)));
    var resp = await dio.post(path, data: data, queryParameters: q).catchError((e) => handleError(e, path));
    PrefController.instance.setLastServerCheck();
    return resp.data;
  }

  /// //////////////// DIO ////////////////////////
  ///
  // dynamic downloadPhoto(String uri, String fileName,
  //     {bool useCache = false}) async {
  //   var dir = await getTemporaryDirectory();
  //   if (!kIsWeb && (useCache || await NetUtil.isNotConnected())) {
  //     File file = File('${dir.path}/$fileName');
  //     bool _exist = file.existsSync();
  //     return file;
  //   }

  //   var dio = _initDio();
  //   log('downloadPhoto.Api => $serverUrl$uri');
  //   Uri? _uri = Uri.tryParse('$serverUrl$uri');
  //   var resp = await dio.getUri<List<int>>(_uri!,
  //       options: dioLib.Options(responseType: dioLib.ResponseType.bytes));
  //   if (kIsWeb) {
  //     //
  //   } else {
  //     File file = File('${dir.path}/$fileName');
  //     var raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(resp.data!);
  //     await raf.close();
  //     return file;
  //   }
  // }

// refer to https://github.com/shahshubh/CampusCar/blob/master/lib/screens/user/home/home_screen.dart
  /// upload('blob:localhost....xyz', mountain.jpg)
  /// filePath is full url of a local file, while fileName is to help server to categorize mime type
  /// return message from server
  // Future<String> _upload_sample(String filePath, String fileName) async {
  //   var formData = dio_lib.FormData();
  //   formData.files.addAll([
  //     MapEntry(
  //         'upload',
  //         kIsWeb
  //             ? dio_lib.MultipartFile.fromBytes(await (XFile(filePath).readAsBytes()),
  //                 filename: fileName) // ternyata fileName itu wajib krn filePath di web suka ga jelas extensionnya apa
  //             : dio_lib.MultipartFile.fromFileSync(
  //                 filePath)) // beda case utk mobile, filePathnya sudah termasuk extensionnya
  //   ]);
  //   formData.fields.add(const MapEntry('regions', 'id'));

  //   final serverUrl = constructHostPort(selectedServerByUser);
  //   var uri = Uri.tryParse('$serverUrl/matel/v1/plate-reader/');

  //   String? progress;
  //   String? percentage;
  //   var dio = await initDio(selectedServerByUser);
  //   dio.interceptors.add(
  //       dio_lib.InterceptorsWrapper(onError: (e, handler) => handleInterceptor4Jwt(selectedServerByUser, e, handler)));

  //   var res = await dio.postUri<String>(
  //     uri!,
  //     options: dio_lib.Options(
  //       method: 'POST',
  //       responseType: dio_lib.ResponseType.json,
  //     ),
  //     data: formData,
  //     onSendProgress: (sent, total) {
  //       percentage = (sent / total * 100).toStringAsFixed(2);
  //       progress = "$percentage % uploaded ($sent / $total Bytes)";
  //       log(progress ?? '');
  //     },
  //   ).then((response) {
  //     log('uploading response $response'); //foto_ldv_depan_rmh_0016074932_0006017179-001.jpg
  //     return response;
  //   }).catchError((error) {
  //     // "{"upload":["The submitted data was not a file. Check the encoding type on the form."]}"
  //     throw Exception(error?.response ?? error.error);
  //   });
  //   return res.toString();
  // }
}
