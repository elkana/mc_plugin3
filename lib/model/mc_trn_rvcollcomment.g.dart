// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mc_trn_rvcollcomment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrnRVCollCommentAdapter extends TypeAdapter<TrnRVCollComment> {
  @override
  final int typeId = 104;

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
      rvCollNo: fields[3] as String?,
      seqNo: fields[4] as int?,
      contractNo: fields[5] as String?,
      collId: fields[7] as String?,
      lkpNo: fields[6] as String?,
      rvbNo: fields[8] as String?,
      instNo: fields[9] as int?,
      receivedAmount: fields[10] as double?,
      penalty: fields[11] as double?,
      collFeeAc: fields[12] as double?,
      lkpFlag: fields[13] as String?,
      delqCode: fields[14] as String?,
      classCode: fields[15] as String?,
      actionPlan: fields[16] as String?,
      potensi: fields[17] as int?,
      planPayAmount: fields[18] as double?,
      mobPhone1: fields[19] as String?,
      whoMet: fields[20] as String?,
      notes: fields[21] as String?,
      promiseDate: fields[22] as int?,
      spjbNo: fields[24] as String?,
      strukNo: fields[25] as String?,
      strukCounter: fields[26] as int?,
      officeCode: fields[23] as String?,
      rating: fields[27] as String?,
      periode: fields[28] as String?,
      ambc: fields[29] as double?,
      latitude: fields[30] as String?,
      longitude: fields[31] as String?,
      lastUpdateBy: fields[32] as String?,
      lastUpdateDate: fields[33] as int?,
      createdBy: fields[35] as String?,
      createdDate: fields[34] as int?,
      lkpDate: fields[36] as int?,
      monthInst: fields[37] as double?,
      deposit: fields[38] as double?,
      cancelledBy: fields[39] as String?,
      cancelledComments: fields[40] as String?,
      cancelledApprove: fields[41] as String?,
      cancelRequest: fields[42] as String?,
      revisitDate: fields[43] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TrnRVCollComment obj) {
    writer
      ..writeByte(44)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.lastSyncMillis)
      ..writeByte(2)
      ..write(obj.modified)
      ..writeByte(3)
      ..write(obj.rvCollNo)
      ..writeByte(4)
      ..write(obj.seqNo)
      ..writeByte(5)
      ..write(obj.contractNo)
      ..writeByte(6)
      ..write(obj.lkpNo)
      ..writeByte(7)
      ..write(obj.collId)
      ..writeByte(8)
      ..write(obj.rvbNo)
      ..writeByte(9)
      ..write(obj.instNo)
      ..writeByte(10)
      ..write(obj.receivedAmount)
      ..writeByte(11)
      ..write(obj.penalty)
      ..writeByte(12)
      ..write(obj.collFeeAc)
      ..writeByte(13)
      ..write(obj.lkpFlag)
      ..writeByte(14)
      ..write(obj.delqCode)
      ..writeByte(15)
      ..write(obj.classCode)
      ..writeByte(16)
      ..write(obj.actionPlan)
      ..writeByte(17)
      ..write(obj.potensi)
      ..writeByte(18)
      ..write(obj.planPayAmount)
      ..writeByte(19)
      ..write(obj.mobPhone1)
      ..writeByte(20)
      ..write(obj.whoMet)
      ..writeByte(21)
      ..write(obj.notes)
      ..writeByte(22)
      ..write(obj.promiseDate)
      ..writeByte(23)
      ..write(obj.officeCode)
      ..writeByte(24)
      ..write(obj.spjbNo)
      ..writeByte(25)
      ..write(obj.strukNo)
      ..writeByte(26)
      ..write(obj.strukCounter)
      ..writeByte(27)
      ..write(obj.rating)
      ..writeByte(28)
      ..write(obj.periode)
      ..writeByte(29)
      ..write(obj.ambc)
      ..writeByte(30)
      ..write(obj.latitude)
      ..writeByte(31)
      ..write(obj.longitude)
      ..writeByte(32)
      ..write(obj.lastUpdateBy)
      ..writeByte(33)
      ..write(obj.lastUpdateDate)
      ..writeByte(34)
      ..write(obj.createdDate)
      ..writeByte(35)
      ..write(obj.createdBy)
      ..writeByte(36)
      ..write(obj.lkpDate)
      ..writeByte(37)
      ..write(obj.monthInst)
      ..writeByte(38)
      ..write(obj.deposit)
      ..writeByte(39)
      ..write(obj.cancelledBy)
      ..writeByte(40)
      ..write(obj.cancelledComments)
      ..writeByte(41)
      ..write(obj.cancelledApprove)
      ..writeByte(42)
      ..write(obj.cancelRequest)
      ..writeByte(43)
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
