import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/home/data/model/release_model.dart';
import 'package:athkari/app/features/home/data/repository/home_repository_imp.dart';
import 'package:athkari/app/features/home/data/repository/releases_repository_imp.dart';
import 'package:athkari/app/features/home/domain/repository/releases_repository.dart';


class GetLatestRelease implements UseCase<ReleaseModel, void> {
  final ReleaseRepositoryImp _homeRepository;
  GetLatestRelease(this._homeRepository);
  @override
  Future<ReleaseModel> call({params}) async {
    return await _homeRepository.getUpdateAPK();
  }
}
