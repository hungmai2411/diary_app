// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingAdapter extends TypeAdapter<Setting> {
  @override
  final int typeId = 2;

  @override
  Setting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Setting(
      reminderHour: fields[0] as int,
      reminderMinute: fields[7] as int,
      language: fields[1] as String,
      theme: fields[2] as String,
      passcode: fields[3] as String?,
      startingDayOfWeek: fields[4] as String,
      hasPasscode: fields[6] as bool,
      hasReminderTime: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Setting obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.reminderHour)
      ..writeByte(1)
      ..write(obj.language)
      ..writeByte(2)
      ..write(obj.theme)
      ..writeByte(3)
      ..write(obj.passcode)
      ..writeByte(4)
      ..write(obj.startingDayOfWeek)
      ..writeByte(5)
      ..write(obj.hasReminderTime)
      ..writeByte(6)
      ..write(obj.hasPasscode)
      ..writeByte(7)
      ..write(obj.reminderMinute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
