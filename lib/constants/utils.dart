import 'package:another_flushbar/flushbar.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

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
      decoration: const BoxDecoration(
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
