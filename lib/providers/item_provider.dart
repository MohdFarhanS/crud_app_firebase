// lib/providers/item_provider.dart

import 'package:flutter/material.dart';
import 'package:crud_app/models/item.dart';
import 'package:crud_app/services/crud_service.dart';
import 'package:crud_app/providers/auth_provider.dart';
import 'dart:async';

class ItemProvider with ChangeNotifier {
  final CrudService _crudService = CrudService();
  List<Item> _items = [];
  bool _isLoading = false;
  final AuthProvider _authProvider;

  StreamSubscription<List<Item>>? _itemsStreamSubscription;

  ItemProvider(this._authProvider) {
    _authProvider.addListener(_onUserChange);
    _onUserChange();
  }

  void _onUserChange() {
    print(
      'DEBUG: [ItemProvider] _onUserChange triggered. User: ${_authProvider.user?.uid}',
    );
    if (_authProvider.user != null) {
      fetchItems();
    } else {
      _items = [];
      _itemsStreamSubscription?.cancel();
      _itemsStreamSubscription = null;
      notifyListeners();
      print('DEBUG: [ItemProvider] User logged out, items cleared.');
    }
  }

  List<Item> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> fetchItems() async {
    if (_authProvider.user == null) {
      print(
        'DEBUG: [ItemProvider] fetchItems called but user is null. Aborting.',
      );
      _items = [];
      notifyListeners();
      return;
    }

    print(
      'DEBUG: [ItemProvider] fetchItems called. Setting isLoading to true.',
    );
    _isLoading = true;
    notifyListeners();

    _itemsStreamSubscription?.cancel(); // Pastikan stream sebelumnya di-cancel

    _itemsStreamSubscription = _crudService
        .getItems(_authProvider.user!.uid)
        .listen(
          (itemsData) {
            print(
              'DEBUG: [ItemProvider] Stream emitted new data! Item count: ${itemsData.length}',
            );
            _items = itemsData;
            _isLoading = false;
            notifyListeners(); // Memicu rebuild Consumer
            print(
              'DEBUG: [ItemProvider] items updated and listeners notified. Current items: $_items',
            );
          },
          onError: (error) {
            _isLoading = false;
            notifyListeners();
            debugPrint(
              'DEBUG: [ItemProvider] Error fetching items from stream: $error',
            );
          },
          onDone: () {
            _isLoading = false;
            notifyListeners();
            print('DEBUG: [ItemProvider] Stream is done.');
          },
        );
  }

  Future<void> addItem(Item item) async {
    if (_authProvider.user == null) {
      throw Exception("User not logged in.");
    }
    item.userId = _authProvider.user!.uid;
    print(
      'DEBUG: [ItemProvider] Adding item: ${item.name} for user: ${item.userId}',
    );
    try {
      await _crudService.addItem(item);
      print('DEBUG: [ItemProvider] Item added successfully.');
      // Stream harusnya otomatis memperbarui list, tidak perlu fetchItems() di sini.
    } catch (e) {
      print('DEBUG: [ItemProvider] Failed to add item: $e');
      rethrow;
    }
  }

  Future<void> updateItem(Item item) async {
    if (_authProvider.user == null) {
      throw Exception("User not logged in.");
    }

    if (item.userId != null && item.userId! != _authProvider.user!.uid) {
      throw Exception("You are not authorized to update this item.");
    }

    item.userId = _authProvider
        .user!
        .uid; // Pastikan userId item yang di-update selalu UID user saat ini.
    print(
      'DEBUG: [ItemProvider] Updating item: ${item.name} with ID: ${item.id} for user: ${item.userId}',
    );
    try {
      await _crudService.updateItem(item);
      print('DEBUG: [ItemProvider] Item updated successfully.');
      // Stream harusnya otomatis memperbarui list, tidak perlu fetchItems() di sini.
    } catch (e) {
      print('DEBUG: [ItemProvider] Failed to update item: $e');
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    if (_authProvider.user == null) {
      throw Exception("User not logged in.");
    }
    print('DEBUG: [ItemProvider] Deleting item with ID: $id');
    try {
      await _crudService.deleteItem(id);
      print('DEBUG: [ItemProvider] Item deleted successfully.');
      // Stream harusnya otomatis memperbarui list, tidak perlu fetchItems() di sini.
      // Namun, karena pengguna menghadapi masalah refresh manual, kita akan biarkan
      // fetchItems() dipanggil dari ItemListPage setelah pop/delete.
    } catch (e) {
      print('DEBUG: [ItemProvider] Failed to delete item: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _authProvider.removeListener(_onUserChange);
    _itemsStreamSubscription?.cancel();
    print('DEBUG: [ItemProvider] ItemProvider disposed.');
    super.dispose();
  }
}
