import 'package:app/widget/kost_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/kost_model.dart';
import '../provider/kost_provider.dart';

import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<String> _daftarTipe = ['Semua', 'Putra', 'Putri', 'Campur'];
  void _bukaDetail(BuildContext context, Kost kost) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(kost: kost)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<KostProvider>();
    final daftarKost = provider.kostList;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('kostku', style: TextStyle(fontSize: 24)),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                // ga rebuild cuman read aj
                onChanged: (teks) => context.read<KostProvider>().cari(teks),
                decoration: InputDecoration(
                  hintText: 'Cari nama atau alamat kost...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: _daftarTipe.map((tipe) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(tipe),
                      selected: provider.tipeTerpilih == tipe,
                      onSelected: (_) =>
                          context.read<KostProvider>().pilihTipe(tipe),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : daftarKost.isEmpty
                  ? const Center(child: Text('Kost tidak ditemukan'))
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        // 1) tentukan jumlah kolom dari lebar yang tersedia
                        final jumlahKolom = constraints.maxWidth >= 600 ? 3 : 2;

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          // 2) jumlah baris = total / kolom (dibulatkan ke atas)
                          itemCount: (daftarKost.length / jumlahKolom).ceil(),
                          itemBuilder: (context, index) {
                            final awal = index * jumlahKolom;

                            // 3) Row berisi sebanyak jumlahKolom kartu
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(jumlahKolom, (i) {
                                final posisi = awal + i;
                                return Expanded(
                                  // posisi melebihi data = kolom dikosongkan
                                  child: posisi < daftarKost.length
                                      ? KostCard(
                                          kost: daftarKost[posisi],
                                          onTap: () => _bukaDetail(
                                            context,
                                            daftarKost[posisi],
                                          ),
                                        )
                                      : const SizedBox(),
                                );
                              }),
                            );
                          },
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
