// lib/core/app_constants.dart

import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'ItemFlow'; // Nama aplikasi yang lebih modern
  static const String welcomeMessage = 'Kelola Item Anda dengan Mudah';

  // Warna Utama (Biru yang lebih dalam/lembut)
  static const Color primaryColor = Color(0xFF42A5F5); // Biru Langit (Light Blue)
  static const Color primaryDarkColor = Color(0xFF1976D2); // Biru Tua
  static const Color accentColor = Color(0xFF64B5F6); // Biru Lebih Cerah
  static const Color buttonColor = Color(0xFF2196F3); // Biru Standar untuk tombol

  // Warna Netral & Status
  static const Color successColor = Color(0xFF66BB6A); // Hijau
  static const Color errorColor = Color(0xFFEF5350); // Merah
  static const Color warningColor = Color(0xFFFFCA28); // Kuning
  static const Color infoColor = Color(0xFF29B6F6); // Biru Muda

  // Warna Teks
  static const Color textColor = Color(0xFF212121); // Hitam Pekat
  static const Color textLightColor = Color(0xFF424242); // Abu-abu gelap
  static const Color hintColor = Color(0xFF9E9E9E); // Abu-abu terang untuk placeholder
  static const Color whiteColor = Colors.white; // Putih bersih

  // Ukuran Font
  static const double largeFontSize = 24.0;
  static const double mediumFontSize = 16.0;
  static const double smallFontSize = 12.0;
  static const double headingFontSize = 28.0; // Ukuran baru untuk judul halaman
  static const double subHeadingFontSize = 20.0; // Ukuran baru untuk sub-judul

  // Spasi & Padding
  static const double paddingLarge = 24.0;
  static const double paddingMedium = 16.0;
  static const double paddingSmall = 8.0;
  static const double spacingLarge = 32.0;
  static const double spacingMedium = 16.0;
  static const double spacingSmall = 8.0;

  // App Bar Titles
  static const String loginTitle = 'Masuk';
  static const String registerTitle = 'Daftar';
  static const String homeTitle = 'Beranda';
  static const String itemListTitle = 'Daftar Item';
  static const String addItemTitle = 'Tambah Item Baru';
  static const String editItemTitle = 'Edit Item';
  static const String itemDetailTitle = 'Detail Item';
  static const String profileTitle = 'Profil Pengguna';
}