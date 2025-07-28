import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/home/data/repository/home_repository_imp.dart';
import 'package:athkari/app/features/home/data/repository/releases_repository_imp.dart';
import 'package:athkari/app/features/home/domain/repository/releases_repository.dart';

class CheckUpdatesUsecase implements UseCase<bool, void> {
  final ReleaseRepositoryImp _homeRepositoryImp;
  CheckUpdatesUsecase(this._homeRepositoryImp);
  @override
  Future<bool> call({void params}) {
    return _homeRepositoryImp.isUpdateAvailable("");
  }
}
