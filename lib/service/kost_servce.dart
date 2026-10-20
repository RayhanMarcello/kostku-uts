import 'package:app/models/kost_model.dart';
import 'package:app/utils/dummy.dart';

class KostService {
  Future<List<Kost>> getKostList() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return dummyKostList;
  }
}
