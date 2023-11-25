// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mst_personal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MstPersonalAdapter extends TypeAdapter<MstPersonal> {
  @override
  final int typeId = 8;

  @override
  MstPersonal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstPersonal(
      id: fields[0] as int?,
      code: fields[1] as String?,
      seqNo: fields[2] as int?,
      description: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstPersonal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.seqNo)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstPersonalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
