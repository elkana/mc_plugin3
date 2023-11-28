// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_ldv_hdr.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OTrnLdvHeaderAdapter extends TypeAdapter<OTrnLdvHeader> {
  @override
  final int typeId = 100;

  @override
  OTrnLdvHeader read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OTrnLdvHeader(
      id: fields[0] as int?,
      ldvNo: fields[1] as String?,
      ldvDate: fields[2] as String?,
      collId: fields[3] as String?,
      collName: fields[4] as String?,
      officeCode: fields[5] as String?,
      officeName: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OTrnLdvHeader obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ldvNo)
      ..writeByte(2)
      ..write(obj.ldvDate)
      ..writeByte(3)
      ..write(obj.collId)
      ..writeByte(4)
      ..write(obj.collName)
      ..writeByte(5)
      ..write(obj.officeCode)
      ..writeByte(6)
      ..write(obj.officeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OTrnLdvHeaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ITrnLdvHeaderAdapter extends TypeAdapter<ITrnLdvHeader> {
  @override
  final int typeId = 101;

  @override
  ITrnLdvHeader read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ITrnLdvHeader(
      id: fields[0] as int?,
      ldvNo: fields[1] as String?,
      ldvDate: fields[2] as String?,
      closeBatch: fields[3] as String?,
      closeBatchDate: fields[4] as String?,
      collId: fields[5] as String?,
      collName: fields[6] as String?,
      officeCode: fields[7] as String?,
      officeName: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ITrnLdvHeader obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ldvNo)
      ..writeByte(2)
      ..write(obj.ldvDate)
      ..writeByte(3)
      ..write(obj.closeBatch)
      ..writeByte(4)
      ..write(obj.closeBatchDate)
      ..writeByte(5)
      ..write(obj.collId)
      ..writeByte(6)
      ..write(obj.collName)
      ..writeByte(7)
      ..write(obj.officeCode)
      ..writeByte(8)
      ..write(obj.officeName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ITrnLdvHeaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
