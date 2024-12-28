import 'package:flutter/material.dart';

class AppThemeColors {
  //* Primary colors
  static const Color kBgColor = Color(0xff202326);
  static const Color kCardBgColor = Color(0xff2F3235);
  static const Color kFloatingABColor = Color.fromARGB(255, 204, 17, 237);
  static const Color kWhiteColor = Colors.white;

  //* Gradient colors and style
  static const Color gradientStart = Color(0XFF01F0FF);
  static const Color gradientEnd = Color(0XFF4441ED);
  LinearGradient kPrimaryGradieant = const LinearGradient(
    colors: [
      gradientStart,
      gradientEnd,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
