// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calibration_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalibrationDataAdapter extends TypeAdapter<CalibrationData> {
  @override
  final int typeId = 2;

  @override
  CalibrationData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalibrationData(
      X: fields[0] as double,
      Y: fields[1] as double,
      timestamp: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CalibrationData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.X)
      ..writeByte(1)
      ..write(obj.Y)
      ..writeByte(2)
      ..write(obj.timestamp);
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
