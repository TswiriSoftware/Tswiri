// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matched_calibration_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatchedCalibrationDataAdapter
    extends TypeAdapter<MatchedCalibrationData> {
  @override
  final int typeId = 4;

  @override
  MatchedCalibrationData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatchedCalibrationData(
      objectSize: fields[0] as double,
      distance: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MatchedCalibrationData obj) {
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
      other is MatchedCalibrationDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
