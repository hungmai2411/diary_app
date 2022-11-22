import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff0EAD69);
  static Color backgroundColor = const Color(0xFFF7F7FB);
  static const Color textPrimaryColor = Color(0xFF1D1E2C);
  static Color orange = const Color(0xFFFE9870);

  static Gradient gradient = const LinearGradient(
    begin: Alignment(1.0, 0.0),
    end: Alignment(-1.0, 0.0),
    colors: [Color(0xff82d84e), Color(0xff0ead69)],
    stops: [0.0, 1.0],
  );
  static Color textSecondColor = const Color(0xFF7D8699);
}
