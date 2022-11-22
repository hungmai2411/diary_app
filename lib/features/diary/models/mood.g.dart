// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodAdapter extends TypeAdapter<Mood> {
  @override
  final int typeId = 1;

  @override
  Mood read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mood(
      name: fields[0] as String,
      image: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Mood obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
