import 'package:app/widget/kost_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/kost_model.dart';
import '../provider/kost_provider.dart';

import 'detail_screen.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({super.key});

  void _bukaDetail(BuildContext context, Kost kost) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(kost: kost)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daftarFavorit = context.watch<KostProvider>().favoritList;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ===== JUDUL =====
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('Favorit', style: TextStyle(fontSize: 24)),
            ),

            // ===== ISI: kosong / daftar =====
            Expanded(
              child: daftarFavorit.isEmpty
                  ? const Center(child: Text('Belum ada kost favorit'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: (daftarFavorit.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        final kiri = index * 2;
                        final kanan = kiri + 1;

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: KostCard(
                                kost: daftarFavorit[kiri],
                                onTap: () =>
                                    _bukaDetail(context, daftarFavorit[kiri]),
                              ),
                            ),
                            Expanded(
                              child: kanan < daftarFavorit.length
                                  ? KostCard(
                                      kost: daftarFavorit[kanan],
                                      onTap: () => _bukaDetail(
                                        context,
                                        daftarFavorit[kanan],
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
