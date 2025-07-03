// lib/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_app/providers/auth_provider.dart'; // Sesuaikan package name
import 'package:crud_app/screens/items/item_list_screen.dart'; // Sesuaikan package name
import 'package:crud_app/screens/profile_screen.dart'; // Sesuaikan package name
import 'package:crud_app/screens/home/home_widgets.dart'; // Sesuaikan package name
import 'package:crud_app/core/app_constants.dart'; // Sesuaikan package name

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // _selectedIndex sekarang dikelola oleh AuthProvider

  static const List<Widget> _widgetOptions = <Widget>[
    HomeContentWidget(),
    ItemListPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final int currentSelectedIndex = authProvider.selectedIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(currentSelectedIndex)),
        elevation: 0,
        // ============= PERUBAHAN DI SINI =============
        // Menghapus tombol logout dari actions AppBar
        actions: const [
          // IconButton(
          //   icon: const Icon(Icons.logout_rounded, color: AppConstants.whiteColor),
          //   tooltip: 'Logout',
          //   onPressed: () async {
          //     await authProvider.signOut();
          //     if (!mounted) return;
          //     Navigator.of(context).pushReplacementNamed('/login');
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //         content: Text('Berhasil Logout', style: TextStyle(color: AppConstants.whiteColor)),
          //         backgroundColor: AppConstants.successColor,
          //       ),
          //     );
          //   },
          // ),
        ],
        // ===============================================
      ),
      body: Center(
        child: _widgetOptions.elementAt(currentSelectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
        currentIndex: currentSelectedIndex,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: AppConstants.hintColor,
        onTap: (index) {
          authProvider.setSelectedIndex(index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppConstants.whiteColor,
        elevation: 8.0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return AppConstants.homeTitle;
      case 1:
        return AppConstants.itemListTitle;
      case 2:
        return AppConstants.profileTitle;
      default:
        return AppConstants.appName;
    }
  }
}