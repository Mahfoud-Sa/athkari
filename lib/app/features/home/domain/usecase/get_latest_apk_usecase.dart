import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/home/data/repository/home_repository_imp.dart';


class GetLatestAPKUsecase implements UseCase<String, void> {
  final HomeRepositoryImp _homeRepository;
  GetLatestAPKUsecase(this._homeRepository);
  @override
  Future<String> call({params}) async {
    return await _homeRepository.getUpdateAPK();
  }
}
