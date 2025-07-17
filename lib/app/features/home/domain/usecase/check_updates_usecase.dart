import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/home/data/repository/home_repository_imp.dart';

class CheckUpdatesUsecase implements UseCase<bool, void> {
  final HomeRepositoryImp _homeRepositoryImp;
  CheckUpdatesUsecase(this._homeRepositoryImp);
  @override
  Future<bool> call({void params}) {
    return _homeRepositoryImp.isUpdateAvailable();
  }
}
