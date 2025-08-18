


// import 'package:athkari/app/core/services/app_database_services.dart';
// import 'package:athkari/app/features/categories/domain/usecase/delete_dekhair_usecase.dart';
// import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:test/scaffolding.dart' hide group, test;

// import 'delete_dekhair.mocks.dart';

// @GenerateMocks([AppDataBaseServices])
// void main() {
//  group("test delete functionality", (){
//   test("test delete dhkar", () async {
//     final mockAppDatabaseServices = MockAppDataBaseServices();
//     final deleteDekharUseCase = DeleteDekharUseCase(mockAppDatabaseServices as DhkarRepositoryImpl);

//     when(mockAppDatabaseServices.adhkaiDao.Delete(any))
//         .thenAnswer((_) async => true);

//     final result = await deleteDekharUseCase.call(params: 1);
    
//     expect(result, isA<Future>());
//     verify(mockAppDatabaseServices.adhkaiDao.Delete(1)).called(1);
//   });
//  }); 
// }