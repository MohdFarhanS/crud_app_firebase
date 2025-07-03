// lib/screens/items/item_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:crud_app/models/item.dart';
import 'package:crud_app/core/app_constants.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class ItemDetailScreen extends StatelessWidget {
  final Item item;
  const ItemDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.itemDetailTitle),
        elevation: 0,
      ),
      body: SingleChildScrollView( // Tambahkan SingleChildScrollView
        padding: const EdgeInsets.all(AppConstants.paddingLarge), // Padding lebih besar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 6, // Bayangan lebih menonjol
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.paddingMedium)),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLarge), // Padding konten Card lebih besar
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Item:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppConstants.hintColor),
                    ),
                    const SizedBox(height: AppConstants.spacingSmall / 2),
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppConstants.primaryDarkColor), // Nama item lebih besar
                    ),
                    const SizedBox(height: AppConstants.spacingLarge), // Spasi lebih besar

                    Text(
                      'Deskripsi:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppConstants.hintColor),
                    ),
                    const SizedBox(height: AppConstants.spacingSmall / 2),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodyLarge, // Teks deskripsi standar
                    ),
                    const SizedBox(height: AppConstants.spacingLarge),

                    if (item.timestamp != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ditambahkan pada:',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppConstants.hintColor),
                          ),
                          const SizedBox(height: AppConstants.spacingSmall / 2),
                          Text(
                            // Format tanggal menggunakan intl
                            DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id_ID').format(item.timestamp!.toDate().toLocal()),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}