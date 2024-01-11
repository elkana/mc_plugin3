// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mc_trn_rvcollcomment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrnRVCollCommentAdapter extends TypeAdapter<TrnRVCollComment> {
  @override
  final int typeId = 105;

  @override
  TrnRVCollComment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrnRVCollComment(
      id: fields[0] as int?,
      lastSyncMillis: fields[1] as int?,
      modified: fields[2] as bool?,
      pk: fields[4] as RvCollPk?,
      seqNo: fields[3] as int?,
      collId: fields[6] as String?,
      ldvNo: fields[5] as String?,
      rvbNo: fields[7] as String?,
      instNo: fields[8] as int?,
      receivedAmount: fields[9] as num?,
      penalty: fields[10] as double?,
      collFeeAc: fields[11] as double?,
      lkpFlag: fields[12] as String?,
      delqCode: fields[13] as String?,
      classCode: fields[14] as String?,
      actionPlan: fields[15] as String?,
      potensi: fields[16] as int?,
      planPayAmount: fields[17] as double?,
      mobPhone1: fields[18] as String?,
      whoMet: fields[19] as String?,
      notes: fields[20] as String?,
      promiseDate: fields[21] as int?,
      spjbNo: fields[23] as String?,
      strukNo: fields[24] as String?,
      strukCounter: fields[25] as int?,
      officeCode: fields[22] as String?,
      rating: fields[26] as String?,
      periode: fields[27] as String?,
      ambc: fields[28] as double?,
      latitude: fields[29] as String?,
      longitude: fields[30] as String?,
      lastUpdateBy: fields[31] as String?,
      lastUpdateDate: fields[32] as int?,
      createdBy: fields[34] as String?,
      createdDate: fields[33] as int?,
      lkpDate: fields[35] as int?,
      monthInst: fields[36] as double?,
      deposit: fields[37] as double?,
      cancelledBy: fields[38] as String?,
      cancelledComments: fields[39] as String?,
      cancelledApprove: fields[40] as String?,
      cancelRequest: fields[41] as String?,
      revisitDate: fields[42] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TrnRVCollComment obj) {
    writer
      ..writeByte(43)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.lastSyncMillis)
      ..writeByte(2)
      ..write(obj.modified)
      ..writeByte(3)
      ..write(obj.seqNo)
      ..writeByte(4)
      ..write(obj.pk)
      ..writeByte(5)
      ..write(obj.ldvNo)
      ..writeByte(6)
      ..write(obj.collId)
      ..writeByte(7)
      ..write(obj.rvbNo)
      ..writeByte(8)
      ..write(obj.instNo)
      ..writeByte(9)
      ..write(obj.receivedAmount)
      ..writeByte(10)
      ..write(obj.penalty)
      ..writeByte(11)
      ..write(obj.collFeeAc)
      ..writeByte(12)
      ..write(obj.lkpFlag)
      ..writeByte(13)
      ..write(obj.delqCode)
      ..writeByte(14)
      ..write(obj.classCode)
      ..writeByte(15)
      ..write(obj.actionPlan)
      ..writeByte(16)
      ..write(obj.potensi)
      ..writeByte(17)
      ..write(obj.planPayAmount)
      ..writeByte(18)
      ..write(obj.mobPhone1)
      ..writeByte(19)
      ..write(obj.whoMet)
      ..writeByte(20)
      ..write(obj.notes)
      ..writeByte(21)
      ..write(obj.promiseDate)
      ..writeByte(22)
      ..write(obj.officeCode)
      ..writeByte(23)
      ..write(obj.spjbNo)
      ..writeByte(24)
      ..write(obj.strukNo)
      ..writeByte(25)
      ..write(obj.strukCounter)
      ..writeByte(26)
      ..write(obj.rating)
      ..writeByte(27)
      ..write(obj.periode)
      ..writeByte(28)
      ..write(obj.ambc)
      ..writeByte(29)
      ..write(obj.latitude)
      ..writeByte(30)
      ..write(obj.longitude)
      ..writeByte(31)
      ..write(obj.lastUpdateBy)
      ..writeByte(32)
      ..write(obj.lastUpdateDate)
      ..writeByte(33)
      ..write(obj.createdDate)
      ..writeByte(34)
      ..write(obj.createdBy)
      ..writeByte(35)
      ..write(obj.lkpDate)
      ..writeByte(36)
      ..write(obj.monthInst)
      ..writeByte(37)
      ..write(obj.deposit)
      ..writeByte(38)
      ..write(obj.cancelledBy)
      ..writeByte(39)
      ..write(obj.cancelledComments)
      ..writeByte(40)
      ..write(obj.cancelledApprove)
      ..writeByte(41)
      ..write(obj.cancelRequest)
      ..writeByte(42)
      ..write(obj.revisitDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrnRVCollCommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RvCollPkAdapter extends TypeAdapter<RvCollPk> {
  @override
  final int typeId = 106;

  @override
  RvCollPk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RvCollPk(
      id: fields[0] as int?,
      rvCollNo: fields[1] as String?,
      contractNo: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RvCollPk obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.rvCollNo)
      ..writeByte(2)
      ..write(obj.contractNo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RvCollPkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
