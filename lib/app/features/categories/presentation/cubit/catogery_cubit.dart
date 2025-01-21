import 'package:athkari/app/features/categories/domain/entities/category.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_catogories_use_case.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_use_case.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:bloc/bloc.dart';

class CategoryCubit extends Cubit<CatogeryState> {
  final GetCatogoriesUseCase _getCatogoriesUseCase;
  final AddCatogoriesUseCase _addCatogoriesUseCase;
  List<CategoryEntity> categoryiList = [];

  CategoryCubit(this._getCatogoriesUseCase, this._addCatogoriesUseCase)
      : super(InitialCategoryState()) {
    emit(LoadingCategoryState());
    FetchData();
  }

  void FetchData() async {
    categoryiList = await _getCatogoriesUseCase.call();

    emit(DoneCategoryState(categoryiList));
  }

  void AddCategory(String name) async {
    await _addCatogoriesUseCase(params: CategoryEntity(name: name));

    FetchData();
  }

  void Loading() async {
    emit(LoadingCategoryState());
  }

  void Search(String query) async {
    var result = categoryiList =
        categoryiList.where((x) => x.name!.contains(query)).toList();
    if (result.length == 0) {
      emit(EmptyCategoryState());
    } else {
      emit(DoneCategoryState(result));
    }
  }
}
