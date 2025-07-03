// lib/screens/items/add_edit_item_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_app/models/item.dart';
import 'package:crud_app/providers/item_provider.dart';
import 'package:crud_app/core/app_constants.dart';

class AddEditItemScreen extends StatefulWidget {
  final Item? item;
  const AddEditItemScreen({super.key, this.item});

  @override
  State<AddEditItemScreen> createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool get _isEditing => widget.item != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _nameController.text = widget.item!.name;
      _descriptionController.text = widget.item!.description;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveItem() async {
    if (_formKey.currentState!.validate()) {
      final itemProvider = Provider.of<ItemProvider>(context, listen: false);

      Item newItem = Item(
        id: _isEditing ? widget.item!.id : null,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
      );

      print('DEBUG: [AddEditItemScreen] Mencoba menyimpan item...');

      try {
        if (_isEditing) {
          await itemProvider.updateItem(newItem);
          if (!mounted) {
            print('DEBUG: [AddEditItemScreen] Widget TIDAK mounted setelah update.');
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item berhasil diperbarui!', style: TextStyle(color: AppConstants.whiteColor)),
              backgroundColor: AppConstants.successColor,
            ),
          );
          print('DEBUG: [AddEditItemScreen] Item berhasil diperbarui. Mencoba pop...');
        } else {
          await itemProvider.addItem(newItem);
          if (!mounted) {
            print('DEBUG: [AddEditItemScreen] Widget TIDAK mounted setelah add.');
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item berhasil ditambahkan!', style: TextStyle(color: AppConstants.whiteColor)),
              backgroundColor: AppConstants.successColor,
            ),
          );
          print('DEBUG: [AddEditItemScreen] Item berhasil ditambahkan. Mencoba pop...');
        }

        if (!mounted) {
          print('DEBUG: [AddEditItemScreen] Widget TIDAK mounted sebelum pop final.');
          return;
        }
        Navigator.of(context).pop();
        print('DEBUG: [AddEditItemScreen] Pop berhasil dieksekusi.');

      } catch (e) {
        print('DEBUG: [AddEditItemScreen] Terjadi error saat menyimpan item: $e');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', ''), style: const TextStyle(color: AppConstants.whiteColor)),
            backgroundColor: AppConstants.errorColor,
          ),
        );
      }
    } else {
      print('DEBUG: [AddEditItemScreen] Validasi form gagal.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? AppConstants.editItemTitle : AppConstants.addItemTitle),
        // ===== MENAMBAHKAN GRADIENT KE APP BAR =====
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppConstants.primaryColor, AppConstants.accentColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // ===========================================
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isEditing ? 'Ubah Detail Item' : 'Isi Detail Item Baru',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppConstants.spacingLarge),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Item',
                  hintText: 'Misal: Laptop Gaming',
                  prefixIcon: Icon(Icons.drive_file_rename_outline_rounded),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama item tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.spacingMedium),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Item',
                  hintText: 'Misal: Laptop Asus ROG terbaru dengan RTX 4070',
                  prefixIcon: Icon(Icons.description_rounded),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi item tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.spacingLarge),
              SizedBox(
                width: double.infinity,
                child: Consumer<ItemProvider>(
                  builder: (context, itemProvider, child) {
                    return ElevatedButton.icon(
                      onPressed: itemProvider.isLoading ? null : _saveItem,
                      icon: Icon(_isEditing ? Icons.save_rounded : Icons.add_box_rounded),
                      label: itemProvider.isLoading
                          ? const CircularProgressIndicator(color: AppConstants.whiteColor)
                          : Text(_isEditing ? 'Simpan Perubahan' : 'Tambah Item', style: Theme.of(context).textTheme.labelLarge),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}