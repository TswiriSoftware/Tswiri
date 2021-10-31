// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qrcodes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

// ignore: camel_case_types
class qrcodesAdapter extends TypeAdapter<QrCodes> {
  @override
  final int typeId = 0;

  @override
  QrCodes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QrCodes()
      ..uid = fields[0] as String
      ..createdDated = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, QrCodes obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.createdDated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is qrcodesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
