// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_photo_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodePhotosEntryAdapter extends TypeAdapter<BarcodePhotosEntry> {
  @override
  final int typeId = 7;

  @override
  BarcodePhotosEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodePhotosEntry(
      uid: fields[0] as int,
      photoData: (fields[1] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
    );
  }

  @override
  void write(BinaryWriter writer, BarcodePhotosEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.photoData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodePhotosEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
