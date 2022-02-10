// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TagEntryAdapter extends TypeAdapter<TagEntry> {
  @override
  final int typeId = 4;

  @override
  TagEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TagEntry(
      tag: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TagEntry obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.tag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
