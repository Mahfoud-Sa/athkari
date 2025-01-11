import 'package:athkari/app/features/daily_wered/data/modules/dhkar.dart';

abstract class DhkarRepository {
  List<Map<String, dynamic>> getAllDhkars();

  Future<List<DhkarModel>> addDhkars();
  // Future<List<DhkarModel>> getAllDhkars();
  // Future<List<DhkarModel>> getAllDhkars();
}
