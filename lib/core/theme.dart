// lib/core/theme.dart

import 'package:flutter/material.dart';
import 'package:crud_app/core/app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: AppConstants.primaryColor,
      hintColor: AppConstants.accentColor,
      scaffoldBackgroundColor: AppConstants.whiteColor,
      brightness: Brightness.light,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: AppConstants.whiteColor,
        titleTextStyle: TextStyle(
          color: AppConstants.whiteColor,
          fontSize: AppConstants.subHeadingFontSize,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppConstants.whiteColor),
        elevation: 4.0,
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: AppConstants.headingFontSize, fontWeight: FontWeight.bold, color: AppConstants.textColor),
        headlineMedium: TextStyle(fontSize: AppConstants.headingFontSize - 2, fontWeight: FontWeight.bold, color: AppConstants.textColor),
        headlineSmall: TextStyle(fontSize: AppConstants.largeFontSize, fontWeight: FontWeight.bold, color: AppConstants.textColor),

        titleLarge: TextStyle(fontSize: AppConstants.subHeadingFontSize, fontWeight: FontWeight.bold, color: AppConstants.textColor),
        titleMedium: TextStyle(fontSize: AppConstants.mediumFontSize + 2, fontWeight: FontWeight.w600, color: AppConstants.textLightColor),
        titleSmall: TextStyle(fontSize: AppConstants.mediumFontSize, fontWeight: FontWeight.w500, color: AppConstants.textLightColor),

        bodyLarge: TextStyle(fontSize: AppConstants.mediumFontSize, color: AppConstants.textLightColor),
        bodyMedium: TextStyle(fontSize: AppConstants.mediumFontSize - 2, color: AppConstants.textLightColor),
        bodySmall: TextStyle(fontSize: AppConstants.smallFontSize, color: AppConstants.hintColor),

        labelLarge: TextStyle(fontSize: AppConstants.mediumFontSize, fontWeight: FontWeight.bold, color: AppConstants.whiteColor),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.buttonColor,
          foregroundColor: AppConstants.whiteColor,
          padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium + 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.paddingMedium)),
          textStyle: const TextStyle(fontSize: AppConstants.mediumFontSize, fontWeight: FontWeight.bold),
          elevation: 3.0,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.primaryColor,
          textStyle: const TextStyle(fontSize: AppConstants.mediumFontSize - 2),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100, // Ini adalah method call, tapi InputDecorationTheme tidak const
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingSmall),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingSmall),
          borderSide: BorderSide(color: AppConstants.hintColor.withOpacity(0.4), width: 1.0), // <--- HAPUS 'const' di sini jika ada
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingSmall),
          borderSide: const BorderSide(color: AppConstants.primaryColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingSmall),
          borderSide: const BorderSide(color: AppConstants.errorColor, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingSmall),
          borderSide: const BorderSide(color: AppConstants.errorColor, width: 2.0),
        ),
        labelStyle: const TextStyle(color: AppConstants.hintColor),
        hintStyle: TextStyle(color: AppConstants.hintColor.withOpacity(0.7)), // <--- HAPUS 'const' DI SINI
        contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium, vertical: AppConstants.paddingMedium),
        prefixIconColor: AppConstants.hintColor,
      ),

      cardTheme: CardThemeData(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.paddingMedium)),
        margin: const EdgeInsets.all(AppConstants.paddingSmall),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: AppConstants.hintColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppConstants.whiteColor,
        elevation: 8.0,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppConstants.primaryColor,
      ),
    );
  }
}