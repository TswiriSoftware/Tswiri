// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'on_image_inter_barcode_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OnImageInterBarcodeDataHiveObjectAdapter
    extends TypeAdapter<OnImageInterBarcodeDataHiveObject> {
  @override
  final int typeId = 0;

  @override
  OnImageInterBarcodeDataHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OnImageInterBarcodeDataHiveObject(
      uid: fields[0] as String,
      uidStart: fields[1] as String,
      uidEnd: fields[2] as String,
      interBarcodeOffset: fields[3] as TypeOffsetHiveObject,
      startDiagonalLength: fields[4] as double,
      endDiagonalLength: fields[5] as double,
      timestamp: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OnImageInterBarcodeDataHiveObject obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.uidStart)
      ..writeByte(2)
      ..write(obj.uidEnd)
      ..writeByte(3)
      ..write(obj.interBarcodeOffset)
      ..writeByte(4)
      ..write(obj.startDiagonalLength)
      ..writeByte(5)
      ..write(obj.endDiagonalLength)
      ..writeByte(6)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnImageInterBarcodeDataHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
