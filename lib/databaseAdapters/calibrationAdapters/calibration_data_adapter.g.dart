// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calibration_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalibrationDataHiveObjectAdapter
    extends TypeAdapter<CalibrationDataHiveObject> {
  @override
  final int typeId = 2;

  @override
  CalibrationDataHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalibrationDataHiveObject(
      timestamp: fields[0] as String,
      averageDiagonalLength: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CalibrationDataHiveObject obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.averageDiagonalLength);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalibrationDataHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
