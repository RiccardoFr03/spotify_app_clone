import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: lightBackground,
    brightness: Brightness.light,
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
      activeTrackColor: black,
      inactiveTrackColor: Colors.black12.withValues(alpha: 0.3),
      thumbColor: black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(
        color: red,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: const TextStyle(
        color: black,
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.all(20),
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: green,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        elevation: 0,
        textStyle: bold_22.copyWith(color: white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: green,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: darkBackground,
    brightness: Brightness.dark,
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
      activeTrackColor: Color(0xffB7B7B7),
      inactiveTrackColor: Colors.grey.withValues(alpha: 0.3),
      thumbColor: Color(0xffB7B7B7),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(
        color: red,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: const TextStyle(
        color: white,
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.all(20),
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: green,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        elevation: 0,
        textStyle: bold_22.copyWith(color: white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: green,
    ),
  );
}
