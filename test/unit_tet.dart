// Import the test package and Counter class
import 'package:athkari/app/core/app_database.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter services are ready
  final _appDataBaseServices = await AppDataBaseServices();
  await _appDataBaseServices.db;
  //await _appDataBaseServices.adhkaiDao.seedEsnads();
  var value = _appDataBaseServices.categoryDao.getCategoriesWithDekars();
  print(value);
}
