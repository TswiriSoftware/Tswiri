// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matched_calibration_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalibrationDataAdapter extends TypeAdapter<CalibrationData> {
  @override
  final int typeId = 4;

  @override
  CalibrationData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalibrationData(
      objectSize: fields[0] as double,
      distance: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CalibrationData obj) {
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
      other is CalibrationDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
