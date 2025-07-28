import 'package:athkari/app/features/home/data/datasources/release_remote_datasources_imp.dart';
import 'package:athkari/app/features/home/data/repository/releases_repository_imp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ReleaseRepositoryImp repository;

  setUp(() {
    final dataSource = ReleaseRemoteDataSorcesImp(githubToken: '');
    repository = ReleaseRepositoryImp(dataSource);
  });



  test('is update Availabe method test ', () async {

bool result=await repository.isUpdateAvailable("1.2.6");
 expect(bool, isA<bool>());
    //expect(apkUrl.endsWith('.apk'), true);
    print('✔ APK download URL: $result');
  });

  
}
