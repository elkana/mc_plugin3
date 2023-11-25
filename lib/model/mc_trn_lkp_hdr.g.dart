// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mc_trn_lkp_hdr.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrnLKPHeaderAdapter extends TypeAdapter<TrnLKPHeader> {
  @override
  final int typeId = 100;

  @override
  TrnLKPHeader read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrnLKPHeader(
      id: fields[0] as int?,
      lastSyncMillis: fields[1] as int?,
      modified: fields[2] as bool?,
      lkpNo: fields[3] as String?,
      lkpDate: fields[4] as int?,
      officeCode: fields[5] as String?,
      collId: fields[6] as String?,
      workFlag: fields[7] as String?,
      closeBatch: fields[8] as String?,
      lastUpdateBy: fields[9] as String?,
      lastUpdateDate: fields[10] as String?,
      createdDate: fields[11] as String?,
      createdBy: fields[12] as String?,
      closeBatchDate: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TrnLKPHeader obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.lastSyncMillis)
      ..writeByte(2)
      ..write(obj.modified)
      ..writeByte(3)
      ..write(obj.lkpNo)
      ..writeByte(4)
      ..write(obj.lkpDate)
      ..writeByte(5)
      ..write(obj.officeCode)
      ..writeByte(6)
      ..write(obj.collId)
      ..writeByte(7)
      ..write(obj.workFlag)
      ..writeByte(8)
      ..write(obj.closeBatch)
      ..writeByte(9)
      ..write(obj.lastUpdateBy)
      ..writeByte(10)
      ..write(obj.lastUpdateDate)
      ..writeByte(11)
      ..write(obj.createdDate)
      ..writeByte(12)
      ..write(obj.createdBy)
      ..writeByte(13)
      ..write(obj.closeBatchDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrnLKPHeaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
