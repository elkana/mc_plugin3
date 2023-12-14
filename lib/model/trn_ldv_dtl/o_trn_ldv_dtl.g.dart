// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_trn_ldv_dtl.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OTrnLdvDetailAdapter extends TypeAdapter<OTrnLdvDetail> {
  @override
  final int typeId = 103;

  @override
  OTrnLdvDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OTrnLdvDetail(
      id: fields[0] as int?,
      pk: fields[1] as LdvDetailPk?,
      lastUpdateBy: fields[2] as String?,
      lastUpdateDate: fields[3] as String?,
      createdBy: fields[4] as String?,
      createdDate: fields[5] as String?,
      custName: fields[6] as String?,
      alamatTagih: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OTrnLdvDetail obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pk)
      ..writeByte(2)
      ..write(obj.lastUpdateBy)
      ..writeByte(3)
      ..write(obj.lastUpdateDate)
      ..writeByte(4)
      ..write(obj.createdBy)
      ..writeByte(5)
      ..write(obj.createdDate)
      ..writeByte(6)
      ..write(obj.custName)
      ..writeByte(7)
      ..write(obj.alamatTagih);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OTrnLdvDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LdvDetailPkAdapter extends TypeAdapter<LdvDetailPk> {
  @override
  final int typeId = 102;

  @override
  LdvDetailPk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LdvDetailPk(
      id: fields[0] as int?,
      contractNo: fields[1] as String?,
      ldvNo: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LdvDetailPk obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.contractNo)
      ..writeByte(2)
      ..write(obj.ldvNo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LdvDetailPkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
