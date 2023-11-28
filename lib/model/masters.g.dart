// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'masters.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MstLdvPersonalAdapter extends TypeAdapter<MstLdvPersonal> {
  @override
  final int typeId = 8;

  @override
  MstLdvPersonal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstLdvPersonal(
      id: fields[0] as int?,
      code: fields[1] as String?,
      seqNo: fields[2] as int?,
      description: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstLdvPersonal obj) {
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
      other is MstLdvPersonalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstLdvPotensiAdapter extends TypeAdapter<MstLdvPotensi> {
  @override
  final int typeId = 9;

  @override
  MstLdvPotensi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstLdvPotensi(
      id: fields[0] as int?,
      seqNo: fields[1] as int?,
      potensi: fields[2] as int?,
      description: fields[3] as String?,
      delqId: fields[4] as String?,
      classCode: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstLdvPotensi obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.seqNo)
      ..writeByte(2)
      ..write(obj.potensi)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.delqId)
      ..writeByte(5)
      ..write(obj.classCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstLdvPotensiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstLdvFlagAdapter extends TypeAdapter<MstLdvFlag> {
  @override
  final int typeId = 6;

  @override
  MstLdvFlag read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstLdvFlag(
      id: fields[0] as int?,
      code: fields[1] as String?,
      label: fields[2] as String?,
      workFlag: fields[3] as String?,
      active: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MstLdvFlag obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.workFlag)
      ..writeByte(4)
      ..write(obj.active);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstLdvFlagAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstLdvDelqReasonAdapter extends TypeAdapter<MstLdvDelqReason> {
  @override
  final int typeId = 5;

  @override
  MstLdvDelqReason read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstLdvDelqReason(
      id: fields[0] as int?,
      seqNo: fields[1] as int?,
      code: fields[2] as String?,
      label: fields[3] as String?,
      description: fields[4] as String?,
      visible: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstLdvDelqReason obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.seqNo)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.label)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.visible);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstLdvDelqReasonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstLdvClassificationAdapter extends TypeAdapter<MstLdvClassification> {
  @override
  final int typeId = 4;

  @override
  MstLdvClassification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstLdvClassification(
      id: fields[0] as int?,
      seqNo: fields[1] as int?,
      code: fields[2] as String?,
      label: fields[3] as String?,
      visible: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstLdvClassification obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.seqNo)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.label)
      ..writeByte(4)
      ..write(obj.visible);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstLdvClassificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstLdvNextActionAdapter extends TypeAdapter<MstLdvNextAction> {
  @override
  final int typeId = 7;

  @override
  MstLdvNextAction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstLdvNextAction(
      id: fields[0] as int?,
      seqNo: fields[1] as int?,
      code: fields[2] as String?,
      label: fields[3] as String?,
      notes: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstLdvNextAction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.seqNo)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.label)
      ..writeByte(4)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstLdvNextActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstLdvStatusAdapter extends TypeAdapter<MstLdvStatus> {
  @override
  final int typeId = 10;

  @override
  MstLdvStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstLdvStatus(
      id: fields[0] as int?,
      code: fields[1] as String?,
      label: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstLdvStatus obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstLdvStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstDocumentAdapter extends TypeAdapter<MstDocument> {
  @override
  final int typeId = 11;

  @override
  MstDocument read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstDocument(
      id: fields[0] as int?,
      code: fields[1] as String?,
      seqNo: fields[2] as int?,
      description: fields[3] as String?,
      visible: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstDocument obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.seqNo)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.visible);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstDocumentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstBankAdapter extends TypeAdapter<MstBank> {
  @override
  final int typeId = 15;

  @override
  MstBank read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstBank(
      id: fields[0] as int?,
      seqNo: fields[1] as int?,
      code: fields[2] as String?,
      name: fields[3] as String?,
      urlLogo: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstBank obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.seqNo)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.urlLogo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstBankAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstOfficeAdapter extends TypeAdapter<MstOffice> {
  @override
  final int typeId = 1;

  @override
  MstOffice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstOffice(
      id: fields[0] as int?,
      code: fields[1] as String?,
      officeName: fields[2] as String?,
      officeType: fields[3] as String?,
      address1: fields[4] as String?,
      address2: fields[5] as String?,
      address3: fields[6] as String?,
      city: fields[7] as String?,
      phone1: fields[8] as String?,
      namaKota: fields[9] as String?,
      branchName: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstOffice obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.officeName)
      ..writeByte(3)
      ..write(obj.officeType)
      ..writeByte(4)
      ..write(obj.address1)
      ..writeByte(5)
      ..write(obj.address2)
      ..writeByte(6)
      ..write(obj.address3)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.phone1)
      ..writeByte(9)
      ..write(obj.namaKota)
      ..writeByte(10)
      ..write(obj.branchName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstOfficeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstPaymentPointAdapter extends TypeAdapter<MstPaymentPoint> {
  @override
  final int typeId = 16;

  @override
  MstPaymentPoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstPaymentPoint(
      id: fields[0] as int?,
      seqNo: fields[1] as int?,
      code: fields[2] as String?,
      name: fields[3] as String?,
      urlLogo: fields[4] as String?,
      barcode: fields[5] as String?,
      barcodeWidth: fields[6] as int?,
      barcodeHeight: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MstPaymentPoint obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.seqNo)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.urlLogo)
      ..writeByte(5)
      ..write(obj.barcode)
      ..writeByte(6)
      ..write(obj.barcodeWidth)
      ..writeByte(7)
      ..write(obj.barcodeHeight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstPaymentPointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstTaskTypeAdapter extends TypeAdapter<MstTaskType> {
  @override
  final int typeId = 2;

  @override
  MstTaskType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstTaskType(
      id: fields[0] as int?,
      code: fields[1] as String?,
      shortDesc: fields[2] as String?,
      fullDesc: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstTaskType obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.shortDesc)
      ..writeByte(3)
      ..write(obj.fullDesc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstTaskTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MstUserRoleAdapter extends TypeAdapter<MstUserRole> {
  @override
  final int typeId = 3;

  @override
  MstUserRole read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MstUserRole(
      id: fields[0] as int?,
      code: fields[1] as String?,
      description: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MstUserRole obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MstUserRoleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
