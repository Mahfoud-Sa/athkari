import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/home/data/repository/home_repository_imp.dart';
import 'package:athkari/app/features/home/domain/repository/releases_repository.dart';


class GetLatestRelease implements UseCase<String, void> {
  final ReleasesRepository _homeRepository;
  GetLatestRelease(this._homeRepository);
  @override
  Future<String> call({params}) async {
    return await _homeRepository.getUpdateAPK();
  }
}
