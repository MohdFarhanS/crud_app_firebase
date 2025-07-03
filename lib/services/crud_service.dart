import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/models/item.dart';

class CrudService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'items';

  Future<void> addItem(Item item) async {
    try {
      // Pastikan item.userId tidak null sebelum menambahkan
      if (item.userId == null || item.userId!.isEmpty) {
        throw Exception("User ID must not be null for adding an item.");
      }
      await _firestore.collection(_collectionName).add(item.toFirestore());
    } catch (e) {
      throw Exception('Gagal menambahkan item: $e');
    }
  }

  Stream<List<Item>> getItems(String userId) {
    return _firestore
        .collection(_collectionName)
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList();
    });
  }

  Future<void> updateItem(Item item) async {
    try {
      if (item.id == null) {
        throw Exception("Item ID must not be null for updating.");
      }
      await _firestore.collection(_collectionName).doc(item.id).update(item.toFirestore());
    } catch (e) {
      throw Exception('Gagal memperbarui item: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _firestore.collection(_collectionName).doc(id).delete();
    } catch (e) {
      throw Exception('Gagal menghapus item: $e');
    }
  }
}