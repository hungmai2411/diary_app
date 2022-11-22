import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff197FC0);
  static Color backgroundColor = const Color(0xFFEBF4FB);
  static Color todayColor = const Color(0xFF5EC0FE);
  static Color selectedColor = const Color(0xFF2699E2);
  static const Color textPrimaryColor = Color(0xFF1D1E2C);
  static const Color textSecondaryColor = Color(0xFF4E687A);

  static Color orange = const Color(0xFFFE9870);
  static Color unNote = const Color(0xFFCFE1EB);
  static Gradient gradient = const LinearGradient(
    begin: Alignment(1.0, 0.0),
    end: Alignment(-1.0, 0.0),
    colors: [Color(0xff82d84e), Color(0xff0ead69)],
    stops: [0.0, 1.0],
  );
  static Color textSecondColor = const Color(0xFF7D8699);
}
