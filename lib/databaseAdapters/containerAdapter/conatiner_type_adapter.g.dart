// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conatiner_type_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContainerTypeAdapter extends TypeAdapter<ContainerType> {
  @override
  final int typeId = 9;

  @override
  ContainerType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ContainerType.area;
      case 1:
        return ContainerType.cabinet;
      case 2:
        return ContainerType.drawer;
      case 3:
        return ContainerType.shelf;
      case 4:
        return ContainerType.box;
      case 5:
        return ContainerType.custom;
      default:
        return ContainerType.area;
    }
  }

  @override
  void write(BinaryWriter writer, ContainerType obj) {
    switch (obj) {
      case ContainerType.area:
        writer.writeByte(0);
        break;
      case ContainerType.cabinet:
        writer.writeByte(1);
        break;
      case ContainerType.drawer:
        writer.writeByte(2);
        break;
      case ContainerType.shelf:
        writer.writeByte(3);
        break;
      case ContainerType.box:
        writer.writeByte(4);
        break;
      case ContainerType.custom:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContainerTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
