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
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color black = Color(0xFF04070A);
}

ColorScheme _colorScheme(BuildContext context) =>
    Theme.of(context).colorScheme.copyWith(
          primary: CompairifuelColors.white,
          onPrimary: CompairifuelColors.lightBlue,
          primaryContainer: CompairifuelColors.blue,
          onPrimaryContainer: CompairifuelColors.veryLightBlue,
          secondary: CompairifuelColors.darkGreen,
          onSecondary: CompairifuelColors.lightGreen,
          secondaryContainer: CompairifuelColors.green,
          onSecondaryContainer: CompairifuelColors.veryLightGreen,
          brightness: Brightness.light,
          error: CompairifuelColors.darkRed,
          onError: CompairifuelColors.white,
          surface: CompairifuelColors.darkBlue,
          onSurface: CompairifuelColors.black,
        );

TextTheme _textTheme(BuildContext context) =>
    Theme.of(context).textTheme.copyWith().apply(
          fontFamily: "Roboto",
          fontFamilyFallback: ["Roboto Serif"],
          displayColor: CompairifuelColors.black,
          bodyColor: CompairifuelColors.black,
        );

ButtonThemeData _buttonTheme(BuildContext context) =>
    Theme.of(context).buttonTheme.copyWith();

DropdownMenuThemeData _dropdownMenuThemeData(BuildContext context) =>
    Theme.of(context).dropdownMenuTheme.copyWith(
          inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
                fillColor: CompairifuelColors.white,
                iconColor: CompairifuelColors.darkBlue,
                hoverColor: CompairifuelColors.lightBlue,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: CompairifuelColors.darkBlue),
                ),
              ),
        );

InputDecorationTheme _inputDecorationTheme(BuildContext context) =>
    Theme.of(context).inputDecorationTheme.copyWith(
          fillColor: CompairifuelColors.white,
          iconColor: CompairifuelColors.darkBlue,
          hoverColor: CompairifuelColors.lightBlue,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: CompairifuelColors.darkBlue),
          ),
        );

AppBarTheme _appBarTheme(BuildContext context) =>
    Theme.of(context).appBarTheme.copyWith(
          iconTheme: const IconThemeData(
            color: CompairifuelColors.black,
          ),
          actionsIconTheme: const IconThemeData(
            color: CompairifuelColors.black,
          ),
        );

IconThemeData _iconThemeData(BuildContext context) =>
    Theme.of(context).iconTheme.copyWith(
          color: CompairifuelColors.black,
        );

ThemeData getTheme(BuildContext context) => ThemeData.from(
      colorScheme: _colorScheme(context),
      textTheme: _textTheme(context),
      useMaterial3: true,
    ).copyWith(
      inputDecorationTheme: _inputDecorationTheme(context),
      dropdownMenuTheme: _dropdownMenuThemeData(context),
      buttonTheme: _buttonTheme(context),
      appBarTheme: _appBarTheme(context),
      iconTheme: _iconThemeData(context),
    );
