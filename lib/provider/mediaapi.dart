import 'package:dio/dio.dart' as dio_lib;
import 'package:image_picker/image_picker.dart';

import '../controller/auth_controller.dart';
import '../model/mc_photo.dart';
import '../model/server_model.dart';
import '../util/commons.dart';
import '../util/constants.dart';
import 'baseapi.dart';

// using dio to upload foto
class MediaApi extends BaseApi {
  static String getImageUri(Server server) => '${server.toAddress()}${Constants.uriMedia}';

  // Future<TblPhoto> uploadPhotoCollateral(
  //     String label, String photoId, String? docId, String filePath, String targetFilename) async {
  //   var gps = await GpsUtil.getCurrentLocationInForeground();
  //   var loggedUser = AuthController.instance.loggedUser;
  //   var formData = dio_lib.FormData();
  //   formData.files.addAll([
  //     MapEntry(
  //         'file',
  //         kIsWeb
  //             ? dio_lib.MultipartFile.fromBytes(await (XFile(filePath).readAsBytes()),
  //                 filename:
  //                     targetFilename) // ternyata fileName itu wajib krn filePath di web suka ga jelas extensionnya apa
  //             : dio_lib.MultipartFile.fromFileSync(
  //                 filePath)) // beda case utk mobile, filePathnya sudah termasuk extensionnya
  //   ]);
  //   formData.fields.add(MapEntry('collateral_id', '$docId'));
  //   formData.fields.add(MapEntry('filename', targetFilename));
  //   formData.fields.add(MapEntry('photo_id', photoId));
  //   formData.fields.add(MapEntry('label', label));
  //   formData.fields.add(MapEntry('user_id', loggedUser?.userId ?? 'unknown'));
  //   formData.fields.add(MapEntry('latitude', '${gps.latitude}'));
  //   formData.fields.add(MapEntry('longitude', '${gps.longitude}'));

  //   String? progress;
  //   String? percentage;
  //   var dio = await initDio(clientLogic?.selectedServer);
  //   dio.interceptors.add(dio_lib.InterceptorsWrapper(
  //       onError: (e, handler) => handleInterceptor4Jwt(clientLogic?.selectedServer, e, handler)));

  //   var uri = BaseApi.getSelectedUri(Constants.uriUploadFotoCollateral);
  //   log('Trying to upload $targetFilename to $uri');
  //   var res = await dio.postUri(
  //     uri,
  //     options: dio_lib.Options(method: 'POST', responseType: dio_lib.ResponseType.json),
  //     data: formData,
  //     onSendProgress: (sent, total) {
  //       percentage = (sent / total * 100).toStringAsFixed(2);
  //       progress = "$percentage % uploaded ($sent / $total Bytes)";
  //       log(progress ?? '');
  //     },
  //   ).then((response) {
  //     log('uploadPhotoCollateral response $response'); //foto_ldv_depan_rmh_0016074932_0006017179-001.jpg
  //     return response.data;
  //   }).catchError((error) {
  //     // "{"upload":["The submitted data was not a file. Check the encoding type on the form."]}"
  //     throw Exception(error?.response ?? error.error);
  //   });
  //   return TblPhoto.fromMap(res!);
  // }

  Future<TrnPhoto?> uploadPhoto(TrnPhoto? photo) async {
    if (photo == null) return null;
    //tanpa extension, apalah artinya upload
    if (null == photo.blobPath) {
      throw Exception('${photo.fileName} need web path');
    }
    if (null == Utility.getFileExtension(photo.fileName!)) {
      throw Exception('${photo.fileName} need extension');
    }
    var fileNameWOPath = Utility.getFilenameWOPath(photo.fileName!);
    var loggedUser = AuthController.instance.loggedUser;
    var formData = dio_lib.FormData();
    formData.files.addAll([
      MapEntry(
          'file',
          dio_lib.MultipartFile.fromBytes(await (XFile(photo.blobPath!).readAsBytes()),
              filename: fileNameWOPath)) // beda case utk mobile, filePathnya sudah termasuk extensionnya
    ]);
    formData.fields.add(MapEntry('source_id', photo.sourceId!));
    formData.fields.add(MapEntry('filename', fileNameWOPath));
    formData.fields.add(MapEntry('contract_no', photo.contractNo ?? '-'));
    formData.fields.add(MapEntry('photo_id', photo.photoId!));
    formData.fields.add(MapEntry('label', photo.label!));
    formData.fields.add(MapEntry('mimeType', photo.mimeType ?? ''));
    formData.fields.add(MapEntry('rev1', photo.rev1 ?? ''));
    formData.fields.add(MapEntry('rev2', photo.rev2 ?? ''));
    formData.fields.add(MapEntry('user_id', loggedUser?.userId ?? 'unknown'));
    formData.fields.add(MapEntry('office_id', loggedUser?.branchId ?? '-'));
    formData.fields.add(MapEntry('latitude', photo.latitude!));
    formData.fields.add(MapEntry('longitude', photo.longitude!));

    String? progress;
    String? percentage;
    var dio = await initDio();
    dio.interceptors.add(dio_lib.InterceptorsWrapper(onError: (e, handler) => handleInterceptor4Jwt(e, handler)));

    var uri = await BaseApi.getSelectedUri(Constants.uriUploadFoto);
    log('Trying to upload ${photo.photoId} $fileNameWOPath to $uri');
    var res = await dio.postUri(
      uri,
      options: dio_lib.Options(method: 'POST', responseType: dio_lib.ResponseType.json),
      data: formData,
      onSendProgress: (sent, total) {
        percentage = (sent / total * 100).toStringAsFixed(2);
        progress = '$percentage % uploaded ($sent / $total Bytes)';
      },
    ).then((response) {
      log('upload ${photo.photoId} response $response'); //foto_ldv_depan_rmh_0016074932_0006017179-001.jpg
      return response.data;
    }).catchError((error) {
      // "{"upload":["The submitted data was not a file. Check the encoding type on the form."]}"
      // throw Exception(error?.response ?? error.error);
      throw error;
    });
    return TrnPhoto.fromMap(res!);
  }

  /// first, upload all photos yg tdk ada created_date, krn created_date dibuat oleh server saat berhasil upload
  /// client diberi kebebasan kirim berkali2
  Future<bool> uploadPhotos(List<TrnPhoto> list) async {
    log('Trying to send ${list.length} foto');
    var success = await Future.wait(list.map((p) async {
      try {
        var resp = await uploadPhoto(p);
        if (resp != null) {
          int idx = list.indexOf(p);
          list[idx] = resp;
          // beda penanganan utk poa / collateral
          // if (p.photoId == PhotoType.repoPoA.fileKey!) {
          //   await TblPhoto.deleteData(TblPhoto.findPoABy(p.sourceId));
          // } else {
          //   await TblPhoto.deleteData(TblPhoto.findCollateralByConcat(
          //       p.sourceId, p.photoId, PrefController.instance.getLoggedUser()!.userId!));
          // }
          // else {
          //   log('Error : Unhandled uploadAllPhoto for $p');
          //   return false;
          // }
          await TrnPhoto().saveOne(resp);
          return true;
        }
        return false;
      } catch (e) {
        if (e is dio_lib.DioException && e.response?.statusCode == 403) rethrow;
        return false;
      }
    }).toList());
    return !success.any((e) => e == false);
  }

  // /// first, upload all photos yg tdk ada created_date, krn created_date dibuat oleh server saat berhasil upload
  // /// client diberi kebebasan kirim berkali2
  // Future<bool> uploadUnsentPhotos() async {
  //   var unsentPhotos = TblPhoto.findAll().where((p) => p.createdDate == null).toList();
  //   var loggedUser = AuthController.instance.loggedUser;
  //   log('Trying to send ${unsentPhotos.length} foto');
  //   var success = await Future.wait(unsentPhotos.map((item) async {
  //     try {
  //       var resp = await uploadPhoto(item);
  //       if (resp != null) {
  //         // beda penanganan utk poa / collateral
  //         if (item.photoId == PhotoType.repoPoA.fileKey!) {
  //           await TblPhoto.deleteData(TblPhoto.findPoABy(item.sourceId));
  //         } else {
  //           await TblPhoto.deleteData(
  //               TblPhoto.findCollateralByConcat(item.sourceId, item.photoId, loggedUser?.userId ?? 'unknown'));
  //         }
  //         await TblPhoto.saveOrUpdate(resp);
  //         return true;
  //       }
  //       return false;
  //     } catch (e) {
  //       return false;
  //     }
  //   }).toList());
  //   return !success.any((e) => e == false);
  // }

  // Future<String> uploadAvatar(XFile file) async {
  //   var gps = await GpsUtil.getCurrentLocationInForeground();
  //   var loggedUser = AuthController.instance.loggedUser;
  //   var formData = dio_lib.FormData();
  //   formData.files.addAll([
  //     MapEntry(
  //         'file',
  //         dio_lib.MultipartFile.fromBytes(await (file.readAsBytes()),
  //             filename: file.name) // ternyata fileName itu wajib krn filePath di web suka ga jelas extensionnya apa
  //         ) // beda case utk mobile, filePathnya sudah termasuk extensionnya
  //   ]);
  //   formData.fields.add(MapEntry('filename', file.name));
  //   formData.fields.add(MapEntry('office_id', loggedUser?.branchId ?? ''));
  //   formData.fields.add(MapEntry('user_id', loggedUser?.userId ?? 'unknown'));
  //   formData.fields.add(MapEntry('latitude', '${gps.latitude}'));
  //   formData.fields.add(MapEntry('longitude', '${gps.longitude}'));

  //   String? progress;
  //   String? percentage;
  //   var dio = await initDio(clientLogic?.selectedServer);
  //   dio.interceptors.add(dio_lib.InterceptorsWrapper(
  //       onError: (e, handler) => handleInterceptor4Jwt(clientLogic?.selectedServer, e, handler)));

  //   var uri = BaseApi.getSelectedUri(Constants.uriUploadAvatar);
  //   log('Trying to upload avatar ${file.name} to $uri');
  //   var res = await dio.postUri(
  //     uri,
  //     options: dio_lib.Options(method: 'POST', responseType: dio_lib.ResponseType.json),
  //     data: formData,
  //     onSendProgress: (sent, total) {
  //       percentage = (sent / total * 100).toStringAsFixed(2);
  //       progress = "$percentage % uploaded ($sent / $total Bytes)";
  //       log(progress ?? '');
  //     },
  //   ).then((response) {
  //     log('uploadAvatar response $response'); //foto_ldv_depan_rmh_0016074932_0006017179-001.jpg
  //     return response.data;
  //   }).catchError((error) {
  //     // "{"upload":["The submitted data was not a file. Check the encoding type on the form."]}"
  //     throw Exception(error?.response ?? error.error);
  //   });
  //   return res;
  // }
}
