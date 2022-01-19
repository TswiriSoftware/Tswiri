// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RelativeQrCodesAdapter extends TypeAdapter<RelativeQrCodes> {
  @override
  final int typeId = 0;

  @override
  RelativeQrCodes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RelativeQrCodes(
      uid: fields[0] as String,
      uidStart: fields[1] as String,
      uidEnd: fields[2] as String,
      x: fields[3] as double,
      y: fields[4] as double,
      timestamp: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RelativeQrCodes obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.uidStart)
      ..writeByte(2)
      ..write(obj.uidEnd)
      ..writeByte(3)
      ..write(obj.x)
      ..writeByte(4)
      ..write(obj.y)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RelativeQrCodesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
