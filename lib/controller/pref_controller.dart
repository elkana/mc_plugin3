import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import '../model/server_model.dart';
import '../model/setup_mobile.dart';
import '../model/user.dart';
import '../util/commons.dart';

// for GetStorage, pls dont use DateTime
// Di controller ini menggunakan 2 storage: get_storage dan secureStorage
extension SetupExtension on String {
  MobileSetup? get setupKey => PrefController.instance.getSetup(this);
  int setupKeyValue1AsInt(String defaultVal) => int.parse(setupKey?.value1 ?? defaultVal);
}

void sessionStop() => PrefController.instance.stopListening();

void sessionStart() => PrefController.instance.startListening();

class PrefController extends GetxController {
  static PrefController instance = Get.find();

  final _keyAppVersion = 'app.version';
  // final _keyAuth = 'auth';
  final _keyLastSelectedServer = 'last.selected.server';
  final _keyRememberUser = 'remember.user';
  final _keyRememberMe = 'rememberme';
  final _keyThemeDark = 'theme.dark';
  final _keyLastMessage = 'last.message';
  final _keyLastServerActiveTime = 'last.server.active.time';
  final _keyAccessToken = 'access.token';
  final _keyRefreshToken = 'refresh.token';
  final _keySetups = 'setups';

  // for session timeout
  final sessionStateStream = StreamController<SessionState>();

  // need GetStorage because no need to use Future.
  final box = GetStorage();
  final secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
    // keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
    // preferencesKeyPrefix: "prefix",
    // sharedPreferencesName: "shared_prefs",
    // storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
  ));
  final List<MobileSetup> userSetups = [];

  // must called in your main
  Future initStorage() => GetStorage.init();
  // Future cleanAll() => box.erase();  too dangerous

  //////////////////// SERVER //////////////////////////////////////////////////
  // bool get hasServerChoice => box.hasData(_keyLastServer);
  // bool get hasServers => box.hasData(_keyServers);
  // Server? get serverChoice {
  //   final map = box.read(_keyLastServer);
  //   if (map == null) return null;
  //   return Server.fromJson(map);
  // }
  // List<Server> get servers {
  //   final data = box.read(_keyServers) ?? {};
  //   return List<Server>.from(data.map((x) => Server.fromJson(x)));
  // }
  // Future<void> setServerChoice(Server value) => box.write(_keyLastServer, value.toJson());
  Future<void> setLastSelectedServer(Server value) =>
      secureStorage.write(key: _keyLastSelectedServer, value: jsonEncode(value.toJson()));

  Future<Server?> get lastSelectedServer async {
    final map = await secureStorage.read(key: _keyLastSelectedServer);
    if (map == null) return null;
    return Server.fromJson(jsonDecode(map));
  }
  // Future<void> setServers(List<Server> servers) => box.write(_keyServers, servers.map((x) => x.toJson()).toList());
  // Future<void> setServers(List<Server> servers) async {
  //   var json = jsonEncode(servers.map((e) => e.toJson()).toList()).toString();
  //   return await secureStorage.write(key: _keyServers, value: json);
  // }

  bool get hasLastServerCheck => box.hasData(_keyLastServerActiveTime);
  Future<void> setLastServerCheck() => box.write(_keyLastServerActiveTime, DateTime.now().toIso8601String());
  DateTime? get lastServerCheck {
    if (!hasLastServerCheck) return null;
    var s = box.read<String>(_keyLastServerActiveTime);
    return s == null ? null : DateTime.tryParse(s);
  }

  /////////////////// USER  ////////////////////////////////////////////////////
  Future<void> setRememberMe(bool value) => box.write(_keyRememberMe, value);
  bool get hasRememberMe => box.hasData(_keyRememberMe);
  bool? get rememberMe => hasRememberMe ? box.read<bool>(_keyRememberMe) : false;

  Future<UserModel?> get rememberUser async {
    String? json = await secureStorage.read(key: _keyRememberUser);
    if (json == null) return null;
    return UserModel.fromJson(json);
  }

  Future<void> setRememberUser(UserModel? val) async {
    if (val == null) {
      await secureStorage.delete(key: _keyRememberUser);
      return;
    }
    return await secureStorage.write(key: _keyRememberUser, value: val.toJson());
  }

  ///please use AuthController.user
  // Future<bool> hasLoggedUser() async {
  //   return await secureStorage.containsKey(key: _keyAuth);
  //   // return box.hasData(_keyAuth);
  // }

  // Future<String> getLoggedUserId() async => (await getLoggedUser())?.userId ?? 'unknown';
  // Future<void> setLoggedUser(UserModel? user) async {
  //   if (user == null) {
  //     await cleanLoggedUserData();
  //   } else {
  //     // var s = user.toJson();
  //     secureStorage.write(key: _keyAuth, value: user.toJson());
  //     // return await box.write(_keyAuth, s);
  //   }
  // }

  // Future<UserModel?> getLoggedUser() async {
  //   if (!await hasLoggedUser()) return null;
  //   // final map = box.read('auth') ?? {};
  //   final map = await secureStorage.read(key: _keyAuth);
  //   if (map == null) return null;
  //   return UserModel.fromJson(map);
  // }

  Future cleanLoggedUserData() async {
    // dont use box.erase. key servers must not be deleted
    // await box.remove('auth');
    // add more here
    userSetups.clear();
    await secureStorage.deleteAll();
  }

  //////////////////  THEME ////////////////////////////////////////////////////
  bool get darkTheme => box.read(_keyThemeDark) ?? false;
  Future<void> setDarkTheme(bool value) => box.write(_keyThemeDark, value);
  bool get hasDarkTheme => box.hasData(_keyThemeDark);
  Future toggleTheme(BuildContext context, bool value) async {
    await DynamicTheme.of(context)!.setTheme(!value ? 0 : 1);
    await setDarkTheme(value);
  }

  bool get _hasLastMessage => box.hasData(_keyLastMessage);
  Future<void> pushLastMessage(String? msg) => box.write(_keyLastMessage, msg);
  Future<void> popLastMessage() async {
    if (!_hasLastMessage) return;
    var msg = box.read<String>(_keyLastMessage);
    // reset
    pushLastMessage(null);
    showToast((msg)!);
  }

  ////////////////////////  ACCESS TOKEN  //////////////////////////////////////
  Future<String?> get accessToken => secureStorage.read(key: _keyAccessToken);
  Future<void> setAccessToken(String? val) async {
    if (val == null) await secureStorage.delete(key: _keyAccessToken);
    return await secureStorage.write(key: _keyAccessToken, value: val);
  }

  Future<String?> get refreshToken => secureStorage.read(key: _keyRefreshToken);
  Future<void> setRefreshToken(String? val) async {
    if (val == null) await secureStorage.delete(key: _keyRefreshToken);
    return await secureStorage.write(key: _keyRefreshToken, value: val);
  }

  Future<void> setAppVersion(String? val) => box.write(_keyAppVersion, val);
  String get appVersion => box.read(_keyAppVersion) ?? '1.1'; // 4 jul 23
  // String get appVersion => box.read(_keyAppVersion) ?? '1.0';

  ////////////////////////  SETUP //////////////////////////////////////////////
  Future<void> setSecureSetups(List<MobileSetup> setups) async {
    String json = jsonEncode(setups.map((i) => i.toJson()).toList()).toString();
    return await secureStorage.write(key: _keySetups, value: json);
  }

  Future<List<MobileSetup>> get secureSetups async {
    String? json = await secureStorage.read(key: _keySetups);
    if (json == null) return [];
    var obj = jsonDecode(json) as List;
    return List<MobileSetup>.from(obj.map((x) => MobileSetup.fromJson(x)));
  }

  // Future<void> setSetups(List<MobileSetup> setups) => box.write(_keySetups, setups.map((x) => x.toJson()).toList());
  // List<MobileSetup> get setups {
  //   final data = box.read(_keySetups) ?? {};
  //   var list = List<MobileSetup>.from(data.map((x) => MobileSetup.fromJson(x)));
  //   return list;
  // }

  // MobileSetup? getSetup(String key) => setups.firstWhereOrNull((p0) => p0.key == key);
  MobileSetup? getSetup(String key) => userSetups.firstWhereOrNull((e) => e.key == key);

  // Future downloadSetup() async {
  //   var resp = await Api.instance.getMobileSetup();
  //   userSetups.assignAll(resp);
  // }

  //////////////////////////////// SESSIONS ////////////////////////////////////
  void stopListening() {
    try {
      log('stop Listening session');
      sessionStateStream.add(SessionState.stopListening);
    } catch (e, s) {
      print(s);
    }
  }

  void startListening() {
    try {
      log('start Listening session');
      sessionStateStream.add(SessionState.startListening);
    } catch (e, s) {
      print(s);
    }
  }
}
