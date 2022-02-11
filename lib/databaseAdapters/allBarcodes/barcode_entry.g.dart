// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodeDataAdapter extends TypeAdapter<BarcodeData> {
  @override
  final int typeId = 6;

  @override
  BarcodeData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodeData(
      barcodeID: fields[0] as int,
      barcodeName: fields[1] as String,
      barcodeSize: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BarcodeData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.barcodeID)
      ..writeByte(1)
      ..write(obj.barcodeName)
      ..writeByte(2)
      ..write(obj.barcodeSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
