import 'package:athkari/app/features/home/data/model/release_model.dart';

abstract class ReleaseRemoteDataSource {
  Future<List<ReleaseModel>> listReleases();
  Future<ReleaseModel> getLatestRelease();
  Future<String> getLatestReleaseWithApk();
}
