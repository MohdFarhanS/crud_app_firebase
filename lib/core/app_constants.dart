// lib/core/app_constants.dart

import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'ItemFlow';
  static const String welcomeMessage = 'Kelola Item Anda dengan Mudah & Modern'; // Pesan lebih menarik

  // Warna Utama (Palet Biru yang Lebih Vibran dan Modern)
  static const Color primaryColor = Color(0xFF5C6BC0); // Indigo yang lebih cerah
  static const Color primaryDarkColor = Color(0xFF3949AB); // Indigo lebih gelap
  static const Color accentColor = Color(0xFF7986CB); // Indigo lebih muda untuk aksen
  static const Color buttonColor = Color(0xFF5C6BC0); // Sama dengan primary untuk konsistensi

  // Warna Netral & Status
  static const Color successColor = Color(0xFF66BB6A); // Hijau tetap
  static const Color errorColor = Color(0xFFEF5350); // Merah tetap
  static const Color warningColor = Color(0xFFFFCA28); // Kuning tetap
  static const Color infoColor = Color(0xFF29B6F6); // Biru muda tetap

  // Warna Teks
  static const Color textColor = Color(0xFF263238); // Abu-abu gelap, hampir hitam
  static const Color textLightColor = Color(0xFF607D8B); // Abu-abu kebiruan
  static const Color hintColor = Color(0xFF90A4AE); // Abu-abu kebiruan terang
  static const Color whiteColor = Colors.white;

  // Ukuran Font
  static const double largeFontSize = 24.0;
  static const double mediumFontSize = 16.0;
  static const double smallFontSize = 12.0;
  static const double headingFontSize = 32.0; // Sedikit lebih besar
  static const double subHeadingFontSize = 22.0; // Sedikit lebih besar

  // Spasi & Padding
  static const double paddingLarge = 28.0; // Sedikit lebih besar
  static const double paddingMedium = 18.0; // Sedikit lebih besar
  static const double paddingSmall = 10.0; // Sedikit lebih besar
  static const double spacingLarge = 40.0; // Lebih besar
  static const double spacingMedium = 20.0; // Lebih besar
  static const double spacingSmall = 10.0; // Lebih besar

  // App Bar Titles
  static const String loginTitle = 'Masuk Akun'; // Ubah teks
  static const String registerTitle = 'Daftar Akun Baru'; // Ubah teks
  static const String homeTitle = 'Beranda Utama'; // Ubah teks
  static const String itemListTitle = 'Daftar Item Anda'; // Ubah teks
  static const String addItemTitle = 'Tambahkan Item Baru'; // Ubah teks
  static const String editItemTitle = 'Edit Detail Item'; // Ubah teks
  static const String itemDetailTitle = 'Detail Item Lengkap'; // Ubah teks
  static const String profileTitle = 'Profil Pengguna Anda'; // Ubah teks
}