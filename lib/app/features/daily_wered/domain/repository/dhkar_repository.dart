import 'package:athkari/app/features/daily_wered/data/modules/dhkar.dart';

abstract class DhkarRepository {
  Future<List<DhkarModel>> getAllDhkars();
}
