import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/delete_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/update_catogories_usecase.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:bloc/bloc.dart';

class CategoryCubit extends Cubit<CatogeryState> {
  final GetCatogoriesUseCase _getCatogoriesUseCase;
  final AddCatogoriesUseCase _addCatogoriesUseCase;
  final UpdateCatogoriesUseCase _updateCatogoriesUseCase;
  final DeleteCatogoriesUseCase _deleteCatogoriesUseCase;
  List<CategoryEntity> categoryiList = [];

  CategoryCubit(this._getCatogoriesUseCase, this._addCatogoriesUseCase,
      this._updateCatogoriesUseCase, this._deleteCatogoriesUseCase)
      : super(InitialCategoryState()) {
    emit(LoadingCategoryState());
    emit(NotifeyCategoryState("تم"));
    FetchData();
  }

  void FetchData() async {
    categoryiList = await _getCatogoriesUseCase.call();

    emit(DoneCategoryState(categoryiList));
  }

  void AddCategory(String name) async {
    var state = await _addCatogoriesUseCase(params: CategoryEntity(name: name));
    emit(NotifeyCategoryState("تم"));
    //print(state);
    FetchData();
  }

  void UpdateCategory(int id, String name) async {
    await _updateCatogoriesUseCase(params: CategoryEntity(name: name, id: id));
    emit(NotifeyCategoryState("تم"));
    //print(state);
    FetchData();
  }

  void Loading() async {
    emit(LoadingCategoryState());
  }

  void Search(String query) async {
    categoryiList =
        categoryiList.where((x) => x.name!.contains(query)).toList();
    if (categoryiList.length == 0) {
      emit(EmptyCategoryState(
          "لا توجد نتيجة لبحثك جرب البحث باستخدام كلمات اخرئ ..."));
    } else {
      emit(DoneCategoryState(categoryiList));
    }
  }

  void DeleteCategory(int id) async {
    await _deleteCatogoriesUseCase.call(params: id);
    emit(NotifeyCategoryState("تم"));
    FetchData();
  }

  void fetchCategoryDetails(int id) async {
    await _deleteCatogoriesUseCase.call(params: id);
    emit(LoadingCategoryState());
    await Future.delayed(Duration(seconds: 1));
    emit(DoneCategoryDetailsState(categoryiList[0]));
    // FetchData();
  }
}
