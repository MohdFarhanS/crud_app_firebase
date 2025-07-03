// lib/screens/home/home_widgets.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_app/core/app_constants.dart';
import 'package:crud_app/providers/auth_provider.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard_rounded, // Ikon dashboard yang menarik
            size: 120, // Ukuran ikon lebih besar
            color: AppConstants.primaryColor,
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          Text(
            'Selamat Datang di ${AppConstants.appName}!',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppConstants.textColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          Text(
            AppConstants.welcomeMessage,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppConstants.textLightColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingLarge * 2), // Spasi lebih besar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                authProvider.setSelectedIndex(1); // Ubah index ke menu 'Item' (index 1)
              },
              icon: const Icon(Icons.list_alt_rounded), // Ikon yang lebih bagus
              label: Text('Kelola Item Saya', style: Theme.of(context).textTheme.labelLarge),
            ),
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          TextButton.icon(
            onPressed: () {
              authProvider.setSelectedIndex(2); // Navigasi ke Profil
            },
            icon: const Icon(Icons.person_outline, color: AppConstants.primaryColor),
            label: Text('Lihat Profil', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppConstants.primaryColor)),
          ),
        ],
      ),
    );
  }
}