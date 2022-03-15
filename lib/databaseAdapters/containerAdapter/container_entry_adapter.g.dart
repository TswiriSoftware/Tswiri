// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_entry_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContainerEntryAdapter extends TypeAdapter<ContainerEntry> {
  @override
  final int typeId = 2;

  @override
  ContainerEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContainerEntry(
      containerUID: fields[0] as String,
      containerType: fields[4] as ContainerType?,
      parentUID: fields[1] as String?,
      name: fields[2] as String?,
      description: fields[3] as String?,
      barcodeUID: fields[5] as String?,
    )..children = (fields[6] as List?)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, ContainerEntry obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.containerUID)
      ..writeByte(1)
      ..write(obj.parentUID)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.containerType)
      ..writeByte(5)
      ..write(obj.barcodeUID)
      ..writeByte(6)
      ..write(obj.children);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContainerEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
