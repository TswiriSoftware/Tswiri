// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_entry_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodeEntryAdapter extends TypeAdapter<BarcodeEntry> {
  @override
  final int typeId = 13;

  @override
  BarcodeEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodeEntry(
      barcodeUID: fields[0] as String,
      position: fields[1] as Vector3Entry,
    );
  }

  @override
  void write(BinaryWriter writer, BarcodeEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.barcodeUID)
      ..writeByte(1)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
