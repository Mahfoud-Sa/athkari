import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository_imp.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/daily_wered/data/repository/daily_wered_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';

class AddToDailyweredUsecase extends UseCase<void, (int, int)> {
 // final CategoryRepositoryImp _categoryRepository;
  final DailyWeredRepositoryImpl _dailyWeredRepositoryImpl;
  AddToDailyweredUsecase(this._dailyWeredRepositoryImpl);

  @override
  Future call({(int, int)? params}) {
    // TODO: implement call
    return _dailyWeredRepositoryImpl.addDhkar(3,6);
  }

  
}
