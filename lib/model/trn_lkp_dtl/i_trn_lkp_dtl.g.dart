// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_trn_lkp_dtl.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ITrnLKPDetailAdapter extends TypeAdapter<ITrnLKPDetail> {
  @override
  final int typeId = 103;

  @override
  ITrnLKPDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ITrnLKPDetail(
      id: fields[0] as int?,
      pk: fields[1] as LdvDetailPk?,
      lastUpdateBy: fields[2] as String?,
      lastUpdateDate: fields[3] as String?,
      createdBy: fields[4] as String?,
      createdDate: fields[5] as String?,
      custName: fields[6] as String?,
      custNo: fields[7] as String?,
      workStatus: fields[8] as String?,
      lkpFlag: fields[9] as String?,
      collectionFee: fields[10] as int?,
      dueDate: fields[11] as DateTime?,
      promiseDate: fields[12] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ITrnLKPDetail obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.custNo)
      ..writeByte(8)
      ..write(obj.workStatus)
      ..writeByte(9)
      ..write(obj.lkpFlag)
      ..writeByte(10)
      ..write(obj.collectionFee)
      ..writeByte(11)
      ..write(obj.dueDate)
      ..writeByte(12)
      ..write(obj.promiseDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ITrnLKPDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
