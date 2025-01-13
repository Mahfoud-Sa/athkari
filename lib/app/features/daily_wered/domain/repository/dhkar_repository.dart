import 'package:athkari/app/features/daily_wered/data/modules/dhkar.dart';

abstract class DhkarRepository {
  Future<List<Map<String, dynamic>>> getAllDhkars();

  Future<bool> addDhkars(String dheer, int esnaad);
  Future<int> totalDekers();
  // Future<List<DhkarModel>> getAllDhkars();
  // Future<List<DhkarModel>> getAllDhkars();
}
