import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const bg = Color(0xFF07111F);
  static const line = Color(0x2197BEDC);
  static const text = Color(0xFFEDF6FF);
  static const muted = Color(0xFF9AAFC3);
  static const cyan = Color(0xFF00D9F5);
  static const purple = Color(0xFF8B7BFF);
  static const green = Color(0xFF53E6B1);
  static const gradientEnd = Color(0xFF8E9DFF);
  static const panelA = Color(0xF00F2236);
  static const panelB = Color(0xF0091827);
  static const tagText = Color(0xFFA9BFD2);
}

extension ColorOpacity on Color {
  /// Returns this colour with the given opacity (0.0 - 1.0).
  Color o(double opacity) => withAlpha((opacity * 255).round());
}

class AppText {
  AppText._();

  static TextStyle display({
    double size = 16,
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.text,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle body({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.text,
    double? height,
    double? letterSpacing,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.dmSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height ?? 1.5,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
    );
  }

  static TextStyle mono({
    double size = 12,
    Color color = AppColors.text,
    double? height,
  }) {
    return GoogleFonts.robotoMono(fontSize: size, color: color, height: height);
  }
}

ThemeData buildTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.cyan,
      surface: AppColors.bg,
    ),
  );
}