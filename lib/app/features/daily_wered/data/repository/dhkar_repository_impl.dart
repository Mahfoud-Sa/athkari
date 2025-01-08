import 'package:athkari/app/features/daily_wered/data/datasources/app_database.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar.dart';
import 'package:athkari/app/features/daily_wered/domain/repository/dhkar_repository.dart';

class DhkarRepositoryImpl implements DhkarRepository {
  final AppDataBaseServices _appDataBaseServices;

  DhkarRepositoryImpl({required AppDataBaseServices appDataBaseServices})
      : _appDataBaseServices = appDataBaseServices;
  @override
  Future<List<DhkarModel>> getAllDhkars() {
    // TODO: implement getAllDhkars
    throw UnimplementedError();
  }
}
