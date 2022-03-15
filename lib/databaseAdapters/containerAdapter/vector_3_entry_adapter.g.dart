// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vector_3_entry_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class Vector3EntryAdapter extends TypeAdapter<Vector3Entry> {
  @override
  final int typeId = 11;

  @override
  Vector3Entry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vector3Entry(
      x: fields[0] as double,
      y: fields[1] as double,
      z: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Vector3Entry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.x)
      ..writeByte(1)
      ..write(obj.y)
      ..writeByte(2)
      ..write(obj.z);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vector3EntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
