// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_data_entry.dart';

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
      uid: fields[0] as String,
      barcodeSize: fields[1] as double,
      isMarker: fields[2] as bool,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BarcodeDataEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.barcodeSize)
      ..writeByte(2)
      ..write(obj.isMarker)
      ..writeByte(3)
      ..write(obj.description);
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
