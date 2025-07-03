// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_app/providers/auth_provider.dart'; // Sesuaikan jika nama proyek Anda beda
import 'package:crud_app/providers/item_provider.dart'; // Sesuaikan jika nama proyek Anda beda
import 'package:crud_app/screens/auth/login_screen.dart'; // Sesuaikan jika nama proyek Anda beda
import 'package:crud_app/screens/home/home_screen.dart'; // Sesuaikan jika nama proyek Anda beda
import 'package:firebase_core/firebase_core.dart';

// PASTIKAN BARIS IMPORT INI ADA DAN PATHNYA BENAR:
import 'package:crud_app/core/theme.dart'; // <--- PASTIKAN PATH INI BENAR (crud_app)
import 'package:crud_app/screens/auth/register_screen.dart'; // Sesuaikan jika nama proyek Anda beda

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Anda bisa menambahkan opsi Firebase di sini jika diperlukan,
    // misalnya FirebaseOptions.currentPlatform jika menggunakan konfigurasi otomatis
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ItemProvider>(
          create: (context) => ItemProvider(Provider.of<AuthProvider>(context, listen: false)),
          update: (context, authProvider, previousItemProvider) =>
              ItemProvider(authProvider),
        ),
      ],
      child: MaterialApp(
        title: 'My Flutter Firebase App',
        theme: AppTheme.lightTheme, // Menggunakan AppTheme
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (authProvider.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return authProvider.user == null ? const LoginScreen() : const HomeScreen();
          },
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/register': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}