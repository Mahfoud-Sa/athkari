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
      : super(InitialCategoryState());

  void FetchData() async {
    categoryiList = await _getCatogoriesUseCase.call();

    emit(DoneCategoryState(categoryiList));
  }

  void AddCategory(String name) async {
    await _addCatogoriesUseCase(params: CategoryEntity(name: name));
    // print(temp);
    // categoryiList = {
    //   "deker": """الصباح""",
    //   "deker": """المساء""",
    //   "deker": """النوم"""
    // };
    FetchData();
    // emit(DoneCategoryState(categoryiList));
  }

  void Loading() async {
    emit(LoadingCategoryState());
  }

  void Search(String query) async {
    // var athkariList = await _dailyWereUseCase.call();
    categoryiList =
        categoryiList.where((x) => x.name!.contains(query)).toList();
    emit(DoneCategoryState(categoryiList));
  }
  // void GetTotalOfDekeers() async {
  //   var total = await _getTotalDailyWereUseCase.call();

  //   emit(DoneState(athkari: athkariList));
  // }

  // void AddDheker(String text_1, String test_2) async {
  //   var athkariList = await _addDhakerUseCase.call();

  //   emit(DoneState(athkari: []));
}
