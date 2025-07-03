// lib/models/item.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String? id;
  String name;
  String description;
  String? userId; // Pastikan ini String?
  Timestamp? timestamp;

  Item({this.id, required this.name, required this.description, this.userId, this.timestamp});

  // Konversi dari Firestore DocumentSnapshot ke objek Item
  factory Item.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>; // Menggunakan Map<String, dynamic> untuk keamanan tipe
    return Item(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      userId: data['userId'] as String?, // <--- PERUBAHAN UTAMA DI SINI: Cast ke String?
      timestamp: data['timestamp'] as Timestamp?,
    );
  }

  // Konversi dari objek Item ke Map untuk disimpan di Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'userId': userId, // Ini akan menyimpan null jika userId adalah null
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }
}