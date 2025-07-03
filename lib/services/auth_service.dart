// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  // Tambahkan parameter 'name' di sini
  Future<User?> signUpWithEmailAndPassword(String email, String password, String name) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Jika pendaftaran berhasil, update display name pengguna
      await result.user?.updateDisplayName(name);
      return result.user;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'Password terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email ini sudah terdaftar.';
      } else {
        message = 'Gagal mendaftar: ${e.message}';
      }
      throw Exception(message);
    } catch (e) {
      throw Exception('Terjadi kesalahan tidak dikenal saat mendaftar: $e');
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'Email tidak terdaftar.';
      } else if (e.code == 'wrong-password') {
        message = 'Password salah.';
      } else if (e.code == 'invalid-email') {
        message = 'Format email tidak valid.';
      } else {
        message = 'Gagal login: ${e.message}';
      }
      throw Exception(message);
    } catch (e) {
      throw Exception('Terjadi kesalahan tidak dikenal saat login: $e');
    }
  }

  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Gagal logout: $e');
    }
  }
}