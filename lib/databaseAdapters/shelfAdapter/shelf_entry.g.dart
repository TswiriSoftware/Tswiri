// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShelfEntryAdapter extends TypeAdapter<ShelfEntry> {
  @override
  final int typeId = 8;

  @override
  ShelfEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShelfEntry(
      uid: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShelfEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShelfEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
