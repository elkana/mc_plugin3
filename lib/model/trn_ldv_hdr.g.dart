// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trn_ldv_hdr.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutboundLdvHeaderAdapter extends TypeAdapter<OutboundLdvHeader> {
  @override
  final int typeId = 100;

  @override
  OutboundLdvHeader read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OutboundLdvHeader(
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
  void write(BinaryWriter writer, OutboundLdvHeader obj) {
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
      other is OutboundLdvHeaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InboundLdvHeaderAdapter extends TypeAdapter<InboundLdvHeader> {
  @override
  final int typeId = 101;

  @override
  InboundLdvHeader read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InboundLdvHeader(
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
  void write(BinaryWriter writer, InboundLdvHeader obj) {
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
      other is InboundLdvHeaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
