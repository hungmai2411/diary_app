// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'mood.g.dart';

@HiveType(typeId: 1)
class Mood {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String image;

  Mood({required this.name, required this.image});

  double getIndex() {
    switch (name) {
      case 'Mood1':
        return 5;
      case 'Mood2':
        return 4;
      case 'Mood3':
        return 3;
      case 'Mood4':
        return 2;
      default:
        return 1;
    }
  }
}
