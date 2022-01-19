// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matched_calibration_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LinearCalibrationDataAdapter extends TypeAdapter<LinearCalibrationData> {
  @override
  final int typeId = 4;

  @override
  LinearCalibrationData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LinearCalibrationData(
      objectSize: fields[0] as double,
      distance: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, LinearCalibrationData obj) {
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
      other is LinearCalibrationDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
