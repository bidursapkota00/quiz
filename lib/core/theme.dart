import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primary, // Primary color
        secondary: AppColors.accent, // Accent color
      ),
      scaffoldBackgroundColor: AppColors.background, // Background color
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary, // AppBar background color
        titleTextStyle: TextStyle(
          color: AppColors.background, // AppBar title text color
          fontSize: 20,
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: AppColors.textColor,
          fontSize: 20,
        ), // Replacing `headline6`
        bodyLarge: TextStyle(
          color: AppColors.textColor,
          fontSize: 16,
        ), // Replacing `bodyText1`
        bodyMedium: TextStyle(
          color: AppColors.textColor,
          fontSize: 14,
        ), // Replacing `bodyText2`
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor, // Button background color
          foregroundColor: Colors.white, // Button text color
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColor),
        ),
      ),
    );
  }
}
