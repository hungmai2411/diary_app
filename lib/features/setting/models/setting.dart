// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:diary_app/constants/bean.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

part 'setting.g.dart';

@HiveType(typeId: 2)
class Setting {
  @HiveField(0)
  final int reminderHour;

  @HiveField(1)
  final String? language;

  @HiveField(2)
  final Bean bean;

  @HiveField(3)
  final String? passcode;

  @HiveField(4)
  final String? startingDayOfWeek;

  @HiveField(5)
  final bool hasReminderTime;

  @HiveField(6)
  final bool hasPasscode;

  @HiveField(7)
  final int reminderMinute;

  @HiveField(8)
  final int point;

  Setting({
    this.reminderHour = 20,
    this.reminderMinute = 0,
    this.language,
    this.passcode,
    this.startingDayOfWeek,
    this.hasPasscode = false,
    this.hasReminderTime = false,
    this.point = 0,
    this.bean = const Bean(nameBean: 'Basic Bean'),
  });

  Setting copyWith({
    int? reminderHour,
    int? reminderMinute,
    String? language,
    String? theme,
    String? passcode,
    String? startingDayOfWeek,
    bool? hasPasscode,
    bool? hasReminderTime,
    int? point,
    Bean? bean,
  }) {
    return Setting(
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      language: language ?? this.language,
      passcode: passcode ?? this.passcode,
      startingDayOfWeek: startingDayOfWeek ?? this.startingDayOfWeek,
      hasPasscode: hasPasscode ?? this.hasPasscode,
      hasReminderTime: hasReminderTime ?? this.hasReminderTime,
      point: point ?? this.point,
      bean: bean ?? this.bean,
    );
  }
}
