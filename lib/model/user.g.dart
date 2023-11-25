// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 21;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      userId: fields[0] as String?,
      userPassword: fields[1] as String?,
      fullName: fields[2] as String?,
      branchId: fields[3] as String?,
      branchName: fields[4] as String?,
      userType: fields[5] as String?,
      region: fields[6] as String?,
      emailAddr: fields[7] as String?,
      needChangePwd: fields[8] as bool?,
      avatarUrl: fields[9] as String?,
      accessToken: fields[10] as String?,
      refreshToken: fields[11] as String?,
      userStatus: fields[12] as String?,
      rememberMe: fields[13] as bool?,
      emailVerified: fields[14] as bool?,
      mobilePhone: fields[15] as String?,
      nik: fields[16] as String?,
      failedAttempt: fields[17] as int?,
      createdDate: fields[18] as String?,
      office: fields[19] as Office?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userPassword)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.branchId)
      ..writeByte(4)
      ..write(obj.branchName)
      ..writeByte(5)
      ..write(obj.userType)
      ..writeByte(6)
      ..write(obj.region)
      ..writeByte(7)
      ..write(obj.emailAddr)
      ..writeByte(8)
      ..write(obj.needChangePwd)
      ..writeByte(9)
      ..write(obj.avatarUrl)
      ..writeByte(10)
      ..write(obj.accessToken)
      ..writeByte(11)
      ..write(obj.refreshToken)
      ..writeByte(12)
      ..write(obj.userStatus)
      ..writeByte(13)
      ..write(obj.rememberMe)
      ..writeByte(14)
      ..write(obj.emailVerified)
      ..writeByte(15)
      ..write(obj.mobilePhone)
      ..writeByte(16)
      ..write(obj.nik)
      ..writeByte(17)
      ..write(obj.failedAttempt)
      ..writeByte(18)
      ..write(obj.createdDate)
      ..writeByte(19)
      ..write(obj.office);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
