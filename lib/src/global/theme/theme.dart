import 'package:flutter/material.dart';

class CompairifuelColors {
  static const Color darkBlue = Color(0xFF004c97);
  static const Color blue = Color(0xFF166cc2);
  static const Color lightBlue = Color(0xFF76b1ec);
  static const Color veryLightBlue = Color(0xFFb9d7f5);
  static const Color darkGreen = Color(0xFF009700);
  static const Color green = Color(0xFF16c21f);
  static const Color lightGreen = Color(0xFF76ec7c);
  static const Color veryLightGreen = Color(0xFFb9f5bc);
  static const Color darkRed = Color(0xFF880000);
  static const Color red = Color(0xFFcc0000);
}

const colorScheme = ColorScheme(
  primary: CompairifuelColors.darkBlue,
  onPrimary: CompairifuelColors.blue,
  primaryContainer: CompairifuelColors.lightBlue,
  onPrimaryContainer: CompairifuelColors.veryLightBlue,
  secondary: CompairifuelColors.darkGreen,
  onSecondary: CompairifuelColors.green,
  secondaryContainer: CompairifuelColors.lightGreen,
  onSecondaryContainer: CompairifuelColors.veryLightGreen,
  brightness: Brightness.light,
  error: CompairifuelColors.darkRed,
  onError: CompairifuelColors.red,
  surface: Color(0x00000000),
  onSurface: Color(0x00000000),
);

final textTheme = const TextTheme().apply(
    fontFamily: "Roboto",
    fontFamilyFallback: ["Roboto Serif"],
    displayColor: Colors.black);

ThemeData getTheme(BuildContext context) => ThemeData.from(
    colorScheme: colorScheme, textTheme: textTheme, useMaterial3: true);
