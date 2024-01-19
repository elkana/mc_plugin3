// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mc_photo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrnPhotoAdapter extends TypeAdapter<TrnPhoto> {
  @override
  final int typeId = 110;

  @override
  TrnPhoto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrnPhoto(
      id: fields[0] as int?,
      sourceId: fields[3] as String?,
      photoId: fields[5] as String?,
      fileName: fields[7] as String?,
      officeId: fields[1] as String?,
      userId: fields[2] as String?,
      contractNo: fields[4] as String?,
      blobPath: fields[6] as String?,
      mimeType: fields[8] as String?,
      rev1: fields[9] as String?,
      rev2: fields[10] as String?,
      label: fields[11] as String?,
      latitude: fields[12] as String?,
      longitude: fields[13] as String?,
      createdBy: fields[14] as String?,
      createdDate: fields[15] as String?,
      lastUpdateBy: fields[16] as String?,
      lastUpdateDate: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TrnPhoto obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.officeId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.sourceId)
      ..writeByte(4)
      ..write(obj.contractNo)
      ..writeByte(5)
      ..write(obj.photoId)
      ..writeByte(6)
      ..write(obj.blobPath)
      ..writeByte(7)
      ..write(obj.fileName)
      ..writeByte(8)
      ..write(obj.mimeType)
      ..writeByte(9)
      ..write(obj.rev1)
      ..writeByte(10)
      ..write(obj.rev2)
      ..writeByte(11)
      ..write(obj.label)
      ..writeByte(12)
      ..write(obj.latitude)
      ..writeByte(13)
      ..write(obj.longitude)
      ..writeByte(14)
      ..write(obj.createdBy)
      ..writeByte(15)
      ..write(obj.createdDate)
      ..writeByte(16)
      ..write(obj.lastUpdateBy)
      ..writeByte(17)
      ..write(obj.lastUpdateDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrnPhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
