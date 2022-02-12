// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodeDataEntryAdapter extends TypeAdapter<BarcodeDataEntry> {
  @override
  final int typeId = 6;

  @override
  BarcodeDataEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodeDataEntry(
      barcodeID: fields[0] as int,
      barcodeSize: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BarcodeDataEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.barcodeID)
      ..writeByte(1)
      ..write(obj.barcodeSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeDataEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
