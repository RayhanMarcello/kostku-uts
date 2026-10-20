import 'package:flutter/material.dart';

import '../models/kost_model.dart';
import '../utils/format_rupiah.dart';

import 'package:provider/provider.dart';

import '../provider/kost_provider.dart';

class DetailScreen extends StatelessWidget {
  final Kost kost;

  const DetailScreen({super.key, required this.kost});

  // Judul section (Lokasi, Deskripsi, dst) dipakai berulang
  Widget _judulSection(String teks) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        teks,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFavorit = context.watch<KostProvider>().isFavorit(kost.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kost'),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<KostProvider>().toggleFavorit(kost.id),
            icon: Icon(
              isFavorit ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // scroll
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ----- Gambar besar -----
                  Image.asset(
                    kost.gambar,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 220,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.apartment, size: 60),
                      );
                    },
                  ),

                  // ----- Info -----
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kost.nama,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(kost.tipe, style: const TextStyle(fontSize: 13)),

                        // Harga
                        const SizedBox(height: 16),
                        const Text(
                          'Harga per Bulan',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatRupiah(kost.harga),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00695C),
                          ),
                        ),

                        // Lokasi
                        _judulSection('Lokasi'),
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Text(kost.alamat),
                        ),

                        // Deskripsi
                        _judulSection('Deskripsi'),
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Text(kost.deskripsi),
                        ),

                        // Fasilitas
                        _judulSection('Fasilitas'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: kost.fasilitas.map((f) {
                            return Container(
                              margin: const EdgeInsets.only(
                                left: 12,
                                bottom: 8,
                              ),
                              child: Text(f),
                            );
                          }).toList(),
                        ),

                        // Pemilik
                        _judulSection('Pemilik Kost'),
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Row(
                            children: [
                              // Avatar bulat
                              Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Nama + nomor (bertumpuk = Column)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    kost.namaPemilik,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone, size: 14),
                                      const SizedBox(width: 4),
                                      Text(kost.noPemilik),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===== TOMBOL BAWAH (tidak ikut scroll) =====
          Container(
            margin: const EdgeInsets.all(12),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {}, // belum berfungsi
              child: const Text('Hubungi Pemilik'),
            ),
          ),
        ],
      ),
    );
  }
}
