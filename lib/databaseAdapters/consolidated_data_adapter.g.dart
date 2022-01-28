// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consolidated_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsolidatedDataAdapter extends TypeAdapter<ConsolidatedData> {
  @override
  final int typeId = 1;

  @override
  ConsolidatedData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsolidatedData(
      uid: fields[0] as String,
      offset: fields[1] as TypeOffset,
      distanceFromCamera: fields[2] as double,
      fixed: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ConsolidatedData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.offset)
      ..writeByte(2)
      ..write(obj.distanceFromCamera)
      ..writeByte(3)
      ..write(obj.fixed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsolidatedDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
