// Import the test package and Counter class
import 'package:athkari/app/core/app_database.dart';
import 'package:test/test.dart';

void main() {
  final _appDataBaseServices = AppDataBaseServices(),
      value = _appDataBaseServices.categoryDao.getCategories();
  print(value);
}
