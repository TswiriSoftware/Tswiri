// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accelerometer_data_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccelerometerDataHiveObjectAdapter
    extends TypeAdapter<AccelerometerDataHiveObject> {
  @override
  final int typeId = 3;

  @override
  AccelerometerDataHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccelerometerDataHiveObject(
      timestamp: fields[0] as int,
      deltaT: fields[1] as int,
      accelerometerData: fields[2] as double,
      distanceMoved: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AccelerometerDataHiveObject obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.deltaT)
      ..writeByte(2)
      ..write(obj.accelerometerData)
      ..writeByte(3)
      ..write(obj.distanceMoved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccelerometerDataHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
