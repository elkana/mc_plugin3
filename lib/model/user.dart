import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../util/commons.dart';
import '../util/hive_util.dart';
import 'office.dart';

part 'user.g.dart';

@HiveType(typeId: HiveUtil.typeIdUserData)
class UserModel extends HiveObject {
  static const syncTableName = 'user_model';

  @HiveField(0)
  String? userId;
  @HiveField(1)
  String? userPassword;
  @HiveField(2)
  String? fullName;
  @HiveField(3)
  String? branchId;
  @HiveField(4)
  String? branchName;
  @HiveField(5)
  String? userType;
  @HiveField(6)
  String? region;
  @HiveField(7)
  String? emailAddr;
  @HiveField(8)
  bool? needChangePwd;
  @HiveField(9)
  String? avatarUrl;
  @HiveField(10)
  String? accessToken;
  @HiveField(11)
  String? refreshToken;
  @HiveField(12)
  String? userStatus;
  @HiveField(13)
  bool? rememberMe;
  @HiveField(14)
  bool? emailVerified;
  @HiveField(15)
  String? mobilePhone;
  @HiveField(16)
  String? nik;
  @HiveField(17)
  int? failedAttempt;
  @HiveField(18)
  String? createdDate;
  @HiveField(19)
  Office? office;

  UserModel({
    this.userId,
    this.userPassword,
    this.fullName,
    this.branchId,
    this.branchName,
    this.userType,
    this.region,
    this.emailAddr,
    this.needChangePwd,
    this.avatarUrl,
    this.accessToken,
    this.refreshToken,
    this.userStatus,
    this.rememberMe,
    this.emailVerified,
    this.mobilePhone,
    this.nik,
    this.failedAttempt,
    this.createdDate,
    this.office,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'userPassword': userPassword,
        'fullName': fullName,
        'branchId': branchId,
        'branchName': branchName,
        'userType': userType,
        'region': region,
        'emailAddr': emailAddr,
        'needChangePwd': needChangePwd,
        'avatarUrl': avatarUrl,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'userStatus': userStatus,
        'rememberMe': rememberMe,
        'emailVerified': emailVerified,
        'mobilePhone': mobilePhone,
        'nik': nik,
        'failedAttempt': failedAttempt,
        'createdDate': createdDate,
        'office': office?.toMap(),
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        userId: map['userId'],
        userPassword: map['userPassword'],
        fullName: map['fullName'],
        branchId: map['branchId'],
        branchName: map['branchName'],
        userType: map['userType'],
        region: map['region'],
        emailAddr: map['emailAddr'],
        needChangePwd: map['needChangePwd'],
        avatarUrl: map['avatarUrl'],
        accessToken: map['accessToken'],
        refreshToken: map['refreshToken'],
        userStatus: map['userStatus'],
        rememberMe: map['rememberMe'],
        emailVerified: map['emailVerified'],
        mobilePhone: map['mobilePhone'],
        nik: map['nik'],
        failedAttempt: map['failedAttempt']?.toInt(),
        createdDate: map['createdDate'],
        office: map['office'] != null ? Office.fromMap(map['office']) : null,
      );

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(userId: $userId, userPassword: $userPassword, fullName: $fullName, branchId: $branchId, branchName: $branchName, userType: $userType, region: $region, emailAddr: $emailAddr, needChangePwd: $needChangePwd, avatarUrl: $avatarUrl, accessToken: $accessToken, refreshToken: $refreshToken, userStatus: $userStatus, rememberMe: $rememberMe, emailVerified: $emailVerified, mobilePhone: $mobilePhone, nik: $nik, failedAttempt: $failedAttempt, createdDate: $createdDate, office: $office)';

  static Future cleanAll() async {
    final box = Hive.box<UserModel>(syncTableName);
    log('cleanup ${box.length} $syncTableName');
    await box.clear();
  }

  static List<UserModel> findAll() {
    final box = Hive.box<UserModel>(syncTableName);
    return box.values.toList().cast<UserModel>();
  }
}
