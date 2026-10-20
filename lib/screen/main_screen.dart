import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'favorite_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _indexAktif = 0; // 0 = Kost, 1 = Favorit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack: semua halaman tetap hidup, hanya satu yang terlihat,
      // jadi teks pencarian dan filter di Home tidak hilang saat pindah tab
      body: IndexedStack(
        index: _indexAktif,
        children: const [HomeScreen(), FavoritScreen()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexAktif,
        onDestinationSelected: (index) {
          setState(() => _indexAktif = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Kost'),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
        ],
      ),
    );
  }
}
