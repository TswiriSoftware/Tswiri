// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_tag_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodeTagEntryAdapter extends TypeAdapter<BarcodeTagEntry> {
  @override
  final int typeId = 3;

  @override
  BarcodeTagEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodeTagEntry(
      barcodeID: fields[0] as int,
      tag: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BarcodeTagEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.barcodeID)
      ..writeByte(1)
      ..write(obj.tag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeTagEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
