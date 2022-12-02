import 'package:another_flushbar/flushbar.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

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
        Icons.info_sharp,
        size: 20.0,
        color: Colors.white,
      ),
    ),
    duration: const Duration(seconds: 3),
  ).show(context);
}
