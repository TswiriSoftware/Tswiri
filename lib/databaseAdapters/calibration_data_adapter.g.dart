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
      timestamp: fields[0] as String,
      averageDiagonalLength: fields[1] as double,
      timestampInt: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CalibrationData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.averageDiagonalLength)
      ..writeByte(3)
      ..write(obj.timestampInt);
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
