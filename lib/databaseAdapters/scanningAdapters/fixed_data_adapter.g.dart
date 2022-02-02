// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FixedDataHiveObjectAdapter extends TypeAdapter<FixedDataHiveObject> {
  @override
  final int typeId = 0;

  @override
  FixedDataHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FixedDataHiveObject(
      uid: fields[0] as String,
      fixed: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FixedDataHiveObject obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.fixed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FixedDataHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
