// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'real_barcode_position_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RealBarcodePositionEntryAdapter
    extends TypeAdapter<RealBarcodePositionEntry> {
  @override
  final int typeId = 0;

  @override
  RealBarcodePositionEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RealBarcodePositionEntry(
      uid: fields[0] as String,
      offset: fields[1] as TypeOffset,
      zOffset: fields[2] as double,
      isMarker: fields[3] as bool,
      shelfUID: fields[4] as int,
      timestamp: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RealBarcodePositionEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.offset)
      ..writeByte(2)
      ..write(obj.zOffset)
      ..writeByte(3)
      ..write(obj.isMarker)
      ..writeByte(4)
      ..write(obj.shelfUID)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RealBarcodePositionEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
