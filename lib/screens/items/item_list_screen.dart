// lib/screens/items/item_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_app/models/item.dart'; // Sesuaikan dengan nama proyek Anda jika berbeda
import 'package:crud_app/providers/item_provider.dart'; // Sesuaikan dengan nama proyek Anda
import 'package:crud_app/screens/items/add_edit_item_screen.dart'; // Sesuaikan dengan nama proyek Anda
import 'package:crud_app/screens/items/item_detail_screen.dart'; // Sesuaikan dengan nama proyek Anda
import 'package:crud_app/core/app_constants.dart'; // Sesuaikan dengan nama proyek Anda

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemProvider>(context, listen: false).fetchItems();
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context, ItemProvider itemProvider, String itemId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Item', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Apakah Anda yakin ingin menghapus item ini?', style: TextStyle(fontSize: AppConstants.mediumFontSize)),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppConstants.errorColor, foregroundColor: Colors.white),
              onPressed: () async {
                Navigator.of(context).pop(); // Tutup dialog
                try {
                  await itemProvider.deleteItem(itemId);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item berhasil dihapus', style: TextStyle(color: Colors.white)),
                      backgroundColor: AppConstants.successColor,
                    ),
                  );
                  await itemProvider.fetchItems();
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal menghapus item: ${e.toString().replaceFirst('Exception: ', '')}', style: TextStyle(color: Colors.white)),
                      backgroundColor: AppConstants.errorColor,
                    ),
                  );
                }
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, child) {
          if (itemProvider.isLoading && itemProvider.items.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: AppConstants.primaryColor));
          }
          if (itemProvider.items.isEmpty) {
            // Konten ini tidak memiliki teks "Daftar Item"
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.checklist_rtl, size: 100, color: AppConstants.hintColor.withOpacity(0.6)),
                    const SizedBox(height: AppConstants.spacingLarge),
                    Text(
                      'Belum ada item yang ditambahkan.\nSaatnya buat yang pertama!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppConstants.textColor.withOpacity(0.7)),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    Text(
                      'Tekan tombol (+) di bawah untuk mulai mengelola item Anda.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppConstants.hintColor),
                    ),
                  ],
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => itemProvider.fetchItems(),
            color: AppConstants.primaryColor,
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingSmall),
              itemCount: itemProvider.items.length,
              itemBuilder: (context, index) {
                final item = itemProvider.items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingSmall, vertical: AppConstants.paddingSmall),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ItemDetailScreen(item: item),
                        ),
                      ).then((_) {
                        itemProvider.fetchItems();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.name,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppConstants.primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: AppConstants.spacingSmall),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: AppConstants.accentColor),
                                    tooltip: 'Edit Item',
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => AddEditItemScreen(item: item),
                                        ),
                                      ).then((_) {
                                        itemProvider.fetchItems();
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_forever, color: AppConstants.errorColor),
                                    tooltip: 'Hapus Item',
                                    onPressed: () => _showDeleteConfirmationDialog(context, itemProvider, item.id!),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: AppConstants.spacingSmall),
                          Text(
                            item.description,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppConstants.textColor.withOpacity(0.8),
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (item.timestamp != null)
                            Padding(
                              padding: const EdgeInsets.only(top: AppConstants.spacingSmall),
                              child: Text(
                                'Ditambahkan: ${item.timestamp!.toDate().toLocal().day}/${item.timestamp!.toDate().toLocal().month}/${item.timestamp!.toDate().toLocal().year}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addItemFAB',
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddEditItemScreen()),
          ).then((_) {
            Provider.of<ItemProvider>(context, listen: false).fetchItems();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}