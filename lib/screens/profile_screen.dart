// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_app/providers/auth_provider.dart';
import 'package:crud_app/core/app_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      body: user == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_off_rounded, size: 80, color: AppConstants.hintColor),
                  const SizedBox(height: AppConstants.spacingMedium),
                  Text(
                    'Anda belum login.\nSilakan login untuk melihat profil Anda.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppConstants.hintColor),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
                          child: Icon(
                            Icons.account_circle_rounded,
                            size: 100,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingMedium),
                        Text(
                          user.displayName ?? 'Pengguna',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppConstants.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppConstants.spacingSmall),
                        Text(
                          user.email ?? 'Tidak Ada Email',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppConstants.textLightColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingLarge),
                  Divider(color: AppConstants.hintColor.withOpacity(0.5)),
                  const SizedBox(height: AppConstants.spacingMedium),

                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.paddingMedium)),
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      child: Column(
                        children: [
                          _buildProfileInfoRow(context, Icons.person_outline_rounded, 'Nama Lengkap', user.displayName ?? 'Belum Diatur'),
                          const Divider(),
                          _buildProfileInfoRow(context, Icons.email_rounded, 'Email', user.email ?? 'Tidak Tersedia'),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacingLarge),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.paddingMedium)),
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.settings_rounded, color: AppConstants.primaryColor),
                          title: Text('Pengaturan Akun', style: Theme.of(context).textTheme.titleSmall),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: AppConstants.hintColor),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Fitur pengaturan akan datang.')),
                            );
                          },
                        ),
                        const Divider(indent: AppConstants.paddingMedium + 8, endIndent: AppConstants.paddingMedium),
                        ListTile(
                          leading: const Icon(Icons.info_outline_rounded, color: AppConstants.primaryColor),
                          title: Text('Tentang Aplikasi', style: Theme.of(context).textTheme.titleSmall),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: AppConstants.hintColor),
                          onTap: () {
                            showAboutDialog(
                              context: context,
                              applicationName: AppConstants.appName,
                              applicationVersion: '1.0.0',
                              applicationLegalese: '© ${DateTime.now().year} All Rights Reserved.',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacingLarge * 2),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await authProvider.signOut();
                        if (!context.mounted) return;
                        Navigator.of(context).pushReplacementNamed('/login');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Berhasil Logout', style: TextStyle(color: AppConstants.whiteColor)),
                            backgroundColor: AppConstants.successColor,
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout_rounded),
                      label: Text('Logout', style: Theme.of(context).textTheme.labelLarge),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.errorColor,
                        foregroundColor: AppConstants.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileInfoRow(BuildContext context, IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppConstants.primaryColor, size: 28),
          const SizedBox(width: AppConstants.spacingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppConstants.hintColor),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}