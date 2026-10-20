String formatRupiah(int angka) {
  final teks = angka.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );
  return 'Rp $teks';
}
