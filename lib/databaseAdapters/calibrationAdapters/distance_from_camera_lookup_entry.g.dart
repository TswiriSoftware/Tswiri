// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distance_from_camera_lookup_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DistanceFromCameraLookupEntryAdapter
    extends TypeAdapter<DistanceFromCameraLookupEntry> {
  @override
  final int typeId = 1;

  @override
  DistanceFromCameraLookupEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DistanceFromCameraLookupEntry(
      onImageBarcodeDiagonalLength: fields[0] as double,
      distanceFromCamera: fields[1] as double,
      actualBarcodeDiagonalLengthKey: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DistanceFromCameraLookupEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.onImageBarcodeDiagonalLength)
      ..writeByte(1)
      ..write(obj.distanceFromCamera)
      ..writeByte(2)
      ..write(obj.actualBarcodeDiagonalLengthKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistanceFromCameraLookupEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
