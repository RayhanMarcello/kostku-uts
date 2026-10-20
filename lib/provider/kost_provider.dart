import 'package:flutter/material.dart';

import '../models/kost_model.dart';
import '../service/kost_servce.dart';

class KostProvider extends ChangeNotifier {
  final KostService _service = KostService();

  // ===== STATE =====
  List<Kost> _semuaKost = [];
  bool _isLoading = false;
  String _keyword = '';
  String _tipeTerpilih = 'Semua';
  final Set<String> _favoritIds = {}; // simpan id kost yang difavoritkan

  // ===== GETTER =====
  bool get isLoading => _isLoading;
  String get tipeTerpilih => _tipeTerpilih;

  List<Kost> get kostList {
    return _semuaKost.where((kost) {
      final cocokTipe = _tipeTerpilih == 'Semua' || kost.tipe == _tipeTerpilih;

      final key = _keyword.toLowerCase();
      final cocokCari =
          kost.nama.toLowerCase().contains(key) ||
          kost.alamat.toLowerCase().contains(key);

      return cocokTipe && cocokCari;
    }).toList();
  }

  // Daftar kost yang id-nya ada di _favoritIds
  List<Kost> get favoritList {
    return _semuaKost.where((k) => _favoritIds.contains(k.id)).toList();
  }

  // Cek apakah satu kost sudah difavoritkan
  bool isFavorit(String id) => _favoritIds.contains(id);

  // ===== ACTION =====
  Future<void> loadKost() async {
    _isLoading = true;
    notifyListeners();

    _semuaKost = await _service.getKostList();

    _isLoading = false;
    notifyListeners();
  }

  void cari(String keyword) {
    _keyword = keyword;
    notifyListeners();
  }

  void pilihTipe(String tipe) {
    _tipeTerpilih = tipe;
    notifyListeners();
  }

  // Sudah favorit -> hapus. Belum -> tambah.
  void toggleFavorit(String id) {
    if (_favoritIds.contains(id)) {
      _favoritIds.remove(id);
    } else {
      _favoritIds.add(id);
    }
    notifyListeners();
  }
}
