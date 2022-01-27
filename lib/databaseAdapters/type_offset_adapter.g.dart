// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_offset_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeOffsetAdapter extends TypeAdapter<TypeOffset> {
  @override
  final int typeId = 5;

  @override
  TypeOffset read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TypeOffset(
      x: fields[0] as double,
      y: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TypeOffset obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.x)
      ..writeByte(1)
      ..write(obj.y);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeOffsetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
