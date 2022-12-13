// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

import 'package:diary_app/constants/app_assets.dart';
part 'bean.g.dart';

@HiveType(typeId: 3)
class Bean {
  @HiveField(0)
  final String nameBean;

  @HiveField(1)
  final List<String> beans;

  const Bean({
    required this.nameBean,
    this.beans = basicBean,
  });
}
