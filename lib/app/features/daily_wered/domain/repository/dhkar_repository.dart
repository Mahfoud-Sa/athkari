import 'package:athkari/app/features/daily_wered/data/modules/dhkar.dart';

abstract class DhkarRepository {
  Future<List<Map<String, dynamic>>> getAllDhkars();

  Future<bool> addDhkar(String dheer, int esnaad);
  Future<int> totalDeker();
  Future<int> updateDhkar(DhkarModel dhkar);
  // Future<List<DhkarModel>> getAllDhkars();
  // Future<List<DhkarModel>> getAllDhkars();
}
