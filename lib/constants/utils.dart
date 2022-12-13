import 'package:another_flushbar/flushbar.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter_quill/flutter_quill.dart';
import 'package:tuple/tuple.dart';

showSnackBar(BuildContext context, String content) {
  final size = MediaQuery.of(context).size;

  Flushbar(
    maxWidth: size.width * .8,
    borderRadius: BorderRadius.circular(10),
    backgroundColor: AppColors.trackSelectedColor,
    flushbarPosition: FlushbarPosition.TOP,
    messageColor: AppColors.textPrimaryColor,
    messageSize: 16,
    message: content,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    icon: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
      ),
      child: const Icon(
        Icons.check,
        size: 20.0,
        color: Colors.white,
      ),
    ),
    duration: const Duration(seconds: 3),
  ).show(context);
}

Future capture(GlobalKey? key) async {
  if (key == null) return null;

  // Tìm object theo key.
  RenderRepaintBoundary? boundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary;

  // Capture object dưới dạng hình ảnh.
  final image = await boundary.toImage(pixelRatio: 3);

  // Chuyển đối tượng hình ảnh đó sang ByteData theo format của png.
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  // Chuyển ByteData sang Uint8List.
  final pngBytes = byteData!.buffer.asUint8List();

  return pngBytes;
}

const baseSpacing = Tuple2<double, double>(6, 0);

DefaultStyles defaultStyles = DefaultStyles(
    h1: DefaultTextBlockStyle(
        AppStyles.regular.copyWith(
          fontSize: 34,
          color: AppColors.textPrimaryColor.withOpacity(0.70),
          height: 1.15,
          fontWeight: FontWeight.w300,
          decoration: TextDecoration.none,
        ),
        const Tuple2(16, 0),
        const Tuple2(0, 0),
        null),
    h2: DefaultTextBlockStyle(
        AppStyles.regular.copyWith(
          fontSize: 24,
          color: AppColors.textPrimaryColor.withOpacity(0.70),
          height: 1.15,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
        ),
        const Tuple2(8, 0),
        const Tuple2(0, 0),
        null),
    h3: DefaultTextBlockStyle(
        AppStyles.regular.copyWith(
          fontSize: 20,
          color: AppColors.textPrimaryColor.withOpacity(0.70),
          height: 1.25,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none,
        ),
        const Tuple2(8, 0),
        const Tuple2(0, 0),
        null),
    paragraph: DefaultTextBlockStyle(
        AppStyles.regular, const Tuple2(0, 0), const Tuple2(0, 0), null),
    bold: const TextStyle(fontWeight: FontWeight.bold),
    italic: const TextStyle(fontStyle: FontStyle.italic),
    small: const TextStyle(fontSize: 12),
    underline: const TextStyle(decoration: TextDecoration.underline),
    strikeThrough: const TextStyle(decoration: TextDecoration.lineThrough),
    inlineCode: InlineCodeStyle(
      backgroundColor: Colors.grey.shade100,
      radius: const Radius.circular(3),
      style: AppStyles.regular,
      header1: AppStyles.regular.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w300,
      ),
      header2: AppStyles.regular.copyWith(fontSize: 22),
      header3: AppStyles.regular.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    link: TextStyle(
      color: AppColors.textPrimaryColor,
      decoration: TextDecoration.underline,
    ),
    placeHolder: DefaultTextBlockStyle(
        AppStyles.regular.copyWith(
          fontSize: 20,
          height: 1.5,
          color: Colors.grey.withOpacity(0.6),
        ),
        const Tuple2(0, 0),
        const Tuple2(0, 0),
        null),
    lists: DefaultListBlockStyle(
        AppStyles.regular, baseSpacing, const Tuple2(0, 6), null, null),
    quote: DefaultTextBlockStyle(
        TextStyle(color: AppStyles.regular.color!.withOpacity(0.6)),
        baseSpacing,
        const Tuple2(6, 2),
        BoxDecoration(
          border: Border(
            left: BorderSide(width: 4, color: Colors.grey.shade300),
          ),
        )),
    code: DefaultTextBlockStyle(
        TextStyle(
          color: Colors.blue.shade900.withOpacity(0.9),
          //fontFamily: fontFamily,
          fontSize: 13,
          height: 1.15,
        ),
        baseSpacing,
        const Tuple2(0, 0),
        BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(2),
        )),
    indent: DefaultTextBlockStyle(
        AppStyles.regular, baseSpacing, const Tuple2(0, 6), null),
    align: DefaultTextBlockStyle(
        AppStyles.regular, const Tuple2(0, 0), const Tuple2(0, 0), null),
    leading: DefaultTextBlockStyle(
        AppStyles.regular, const Tuple2(0, 0), const Tuple2(0, 0), null),
    sizeSmall: const TextStyle(fontSize: 10),
    sizeLarge: const TextStyle(fontSize: 18),
    sizeHuge: const TextStyle(fontSize: 22));
