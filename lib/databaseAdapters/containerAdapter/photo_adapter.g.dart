// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoEntryAdapter extends TypeAdapter<PhotoEntry> {
  @override
  final int typeId = 12;

  @override
  PhotoEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoEntry(
      photoUID: fields[0] as String,
      containerUID: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.photoUID)
      ..writeByte(1)
      ..write(obj.containerUID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
