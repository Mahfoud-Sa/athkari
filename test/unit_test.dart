// Import the test package and Counter class
import 'package:athkari/app/core/app_database.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:sqflite/sqflite.dart'; // Import the sqflite packag
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  // Initialize the database factory for FFI
  databaseFactory = databaseFactoryFfi;

  // Ensure Flutter services are ready
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize your database services
  final _appDataBaseServices = await AppDataBaseServices();

  // Wait for the database to be ready
  await _appDataBaseServices.db;

  // Seed your data
  // await _appDataBaseServices.adhkaiDao.seedEsnads();

  // Fetch the data
  var value = await _appDataBaseServices.esnadDao.getAllEsnadsWithDekars();

  // Print the fetched value
  print(value);
}
