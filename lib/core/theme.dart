// lib/core/theme.dart

import 'package:flutter/material.dart';
import 'package:crud_app/core/app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.indigo, // Menggunakan Colors.indigo untuk primarySwatch
      primaryColor: AppConstants.primaryColor,
      hintColor: AppConstants.accentColor,
      scaffoldBackgroundColor: AppConstants.whiteColor,
      brightness: Brightness.light,
      fontFamily: 'Roboto', // Menambahkan font family yang umum dan bersih

      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.primaryDarkColor, // AppBar lebih gelap sedikit dari primary
        foregroundColor: AppConstants.whiteColor,
        titleTextStyle: TextStyle(
          color: AppConstants.whiteColor,
          fontSize: AppConstants.subHeadingFontSize,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8, // Menambahkan jarak antar huruf
        ),
        iconTheme: IconThemeData(color: AppConstants.whiteColor),
        elevation: 6.0, // Bayangan AppBar sedikit lebih menonjol
        centerTitle: true, // Judul AppBar di tengah
      ),

      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: AppConstants.headingFontSize, fontWeight: FontWeight.bold, color: AppConstants.textColor),
        headlineMedium: TextStyle(fontSize: AppConstants.headingFontSize - 4, fontWeight: FontWeight.bold, color: AppConstants.textColor),
        headlineSmall: TextStyle(fontSize: AppConstants.largeFontSize, fontWeight: FontWeight.bold, color: AppConstants.textColor),

        titleLarge: TextStyle(fontSize: AppConstants.subHeadingFontSize, fontWeight: FontWeight.w700, color: AppConstants.textColor), // Lebih tebal
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
          padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium + 4), // Padding lebih besar
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.paddingLarge)), // Radius lebih besar
          textStyle: const TextStyle(fontSize: AppConstants.mediumFontSize, fontWeight: FontWeight.bold),
          elevation: 5.0, // Bayangan tombol lebih menonjol
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.primaryColor,
          textStyle: const TextStyle(fontSize: AppConstants.mediumFontSize - 2, fontWeight: FontWeight.w600), // Lebih tebal
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade50, // Warna isian input lebih terang
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingMedium), // Radius border input
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
          borderSide: BorderSide(color: AppConstants.hintColor.withOpacity(0.5), width: 1.5), // Border lebih terlihat
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
          borderSide: const BorderSide(color: AppConstants.primaryColor, width: 2.5), // Border fokus lebih tebal
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
          borderSide: const BorderSide(color: AppConstants.errorColor, width: 2.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
          borderSide: const BorderSide(color: AppConstants.errorColor, width: 2.5),
        ),
        labelStyle: const TextStyle(color: AppConstants.hintColor, fontWeight: FontWeight.w500),
        hintStyle: TextStyle(color: AppConstants.hintColor.withOpacity(0.8), fontStyle: FontStyle.italic), // Hint lebih jelas
        contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge, vertical: AppConstants.paddingMedium),
        prefixIconColor: AppConstants.hintColor,
      ),

      cardTheme: CardThemeData(
        elevation: 8.0, // Bayangan card lebih menonjol
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.paddingLarge)), // Radius card lebih besar
        margin: const EdgeInsets.all(AppConstants.paddingSmall),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: AppConstants.textLightColor, // Warna item tidak terpilih lebih gelap
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppConstants.whiteColor,
        elevation: 10.0, // Bayangan BottomNav lebih menonjol
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: AppConstants.smallFontSize),
        unselectedLabelStyle: TextStyle(fontSize: AppConstants.smallFontSize - 2),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppConstants.primaryColor,
      ),
    );
  }
}