// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:diary_app/features/diary/models/mood.dart';

part 'diary.g.dart';

@HiveType(typeId: 0)
class Diary {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final Mood mood;

  @HiveField(2)
  final String? content;

  @HiveField(3)
  final List<Uint8List>? images;
  Diary({
    required this.id,
    required this.mood,
    this.content,
    this.images,
  });

  Diary copyWith({
    String? id,
    Mood? mood,
    String? content,
    List<Uint8List>? images,
  }) {
    return Diary(
      id: id ?? this.id,
      mood: mood ?? this.mood,
      content: content ?? this.content,
      images: images ?? this.images,
    );
  }
}
