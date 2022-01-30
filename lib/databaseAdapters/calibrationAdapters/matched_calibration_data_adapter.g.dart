// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matched_calibration_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatchedCalibrationDataHiveObjectAdapter
    extends TypeAdapter<MatchedCalibrationDataHiveObject> {
  @override
  final int typeId = 4;

  @override
  MatchedCalibrationDataHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatchedCalibrationDataHiveObject(
      objectSize: fields[0] as double,
      distance: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MatchedCalibrationDataHiveObject obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.objectSize)
      ..writeByte(1)
      ..write(obj.distance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchedCalibrationDataHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
