// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mc_trn_coll_pos.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrnCollPosAdapter extends TypeAdapter<TrnCollPos> {
  @override
  final int typeId = 118;

  @override
  TrnCollPos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrnCollPos(
      id: fields[0] as int?,
      uid: fields[1] as String?,
      userId: fields[2] as String?,
      latitude: fields[3] as String?,
      longitude: fields[4] as String?,
      lastUpdateDate: fields[5] as String?,
      lastSyncDate: fields[6] as String?,
      permissionType: fields[7] as String?,
      logMethod: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TrnCollPos obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.lastUpdateDate)
      ..writeByte(6)
      ..write(obj.lastSyncDate)
      ..writeByte(7)
      ..write(obj.permissionType)
      ..writeByte(8)
      ..write(obj.logMethod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrnCollPosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
