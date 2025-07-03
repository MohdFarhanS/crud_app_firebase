// lib/screens/items/item_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:crud_app/models/item.dart';
import 'package:crud_app/core/app_constants.dart';
import 'package:intl/intl.dart';

class ItemDetailScreen extends StatelessWidget {
  final Item item;
  const ItemDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.itemDetailTitle),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.paddingMedium)),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
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
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppConstants.primaryDarkColor),
                    ),
                    const SizedBox(height: AppConstants.spacingLarge),

                    Text(
                      'Deskripsi:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppConstants.hintColor),
                    ),
                    const SizedBox(height: AppConstants.spacingSmall / 2),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodyLarge,
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