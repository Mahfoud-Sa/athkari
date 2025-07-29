import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/home/data/repository/releases_repository_imp.dart';

class CheckUpdatesUsecase implements UseCase<bool, String> {
  final ReleaseRepositoryImp _homeRepositoryImp;
  CheckUpdatesUsecase(this._homeRepositoryImp);
  
 @override
Future<bool> call({  String? params}) {
  return _homeRepositoryImp.isUpdateAvailable(params??"1.0.0");
}
}