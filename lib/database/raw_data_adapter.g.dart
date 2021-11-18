// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QrCodesAdapter extends TypeAdapter<QrCodes> {
  @override
  final int typeId = 0;

  @override
  QrCodes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QrCodes(
      uid: fields[0] as String,
      vector: (fields[1] as List).cast<dynamic>(),
      createdDated: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QrCodes obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.vector)
      ..writeByte(2)
      ..write(obj.createdDated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QrCodesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
