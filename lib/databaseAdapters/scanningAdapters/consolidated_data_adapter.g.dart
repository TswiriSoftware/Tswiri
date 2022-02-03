// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consolidated_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsolidatedDataHiveObjectAdapter
    extends TypeAdapter<RealPositionData> {
  @override
  final int typeId = 1;

  @override
  RealPositionData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RealPositionData(
      uid: fields[0] as String,
      offset: fields[1] as TypeOffsetHiveObject,
      distanceFromCamera: fields[2] as double,
      fixed: fields[3] as bool,
      timestamp: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RealPositionData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.offset)
      ..writeByte(2)
      ..write(obj.distanceFromCamera)
      ..writeByte(3)
      ..write(obj.fixed)
      ..writeByte(4)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsolidatedDataHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
