// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:diary_app/features/diary/models/mood.dart';

part 'diary.g.dart';

@HiveType(typeId: 0)
class Diary {
  @HiveField(0)
  final Mood mood;

  @HiveField(1)
  final String? content;

  @HiveField(2)
  final List<Uint8List>? images;

  @HiveField(3)
  final DateTime createdAt;

  Diary({
    required this.mood,
    required this.createdAt,
    this.content,
    this.images,
  });

  Diary copyWith({
    Mood? mood,
    String? content,
    List<Uint8List>? images,
    DateTime? createdAt,
  }) {
    return Diary(
      mood: mood ?? this.mood,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      images: images ?? this.images,
    );
  }
}
