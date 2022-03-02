// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_photo_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodePhotoEntryAdapter extends TypeAdapter<BarcodePhotoEntry> {
  @override
  final int typeId = 7;

  @override
  BarcodePhotoEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodePhotoEntry(
      barcodeID: fields[0] as int,
      photoPath: fields[1] as String,
      photoTags: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BarcodePhotoEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.barcodeID)
      ..writeByte(1)
      ..write(obj.photoPath)
      ..writeByte(2)
      ..write(obj.photoTags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodePhotoEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
