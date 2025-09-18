import 'dart:async';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/delete_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/update_catogories_usecase.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/get_all_esnad_usecase.dart';
import 'package:bloc/bloc.dart';

class CategoryCubit extends Cubit<CatogeryState> {
  final GetCatogoriesUseCase _getCatogoriesUseCase;
  final AddCatogoriesUseCase _addCatogoriesUseCase;
  final UpdateCatogoriesUseCase _updateCatogoriesUseCase;
  final DeleteCatogoriesUseCase _deleteCatogoriesUseCase;
  final GetAllEsnadUseCase _getallEsnadUseCase;

  List<CategoryEntity> categoryiList = [];

  /// 🔹 NEW: a stream controller for auto-updates
  final _categoriesController = StreamController<List<CategoryEntity>>.broadcast();
  Stream<List<CategoryEntity>> get categoriesStream => _categoriesController.stream;

  CategoryCubit(
    this._getCatogoriesUseCase,
    this._addCatogoriesUseCase,
    this._updateCatogoriesUseCase,
    this._deleteCatogoriesUseCase,
    this._getallEsnadUseCase,
  ) : super(InitialCategoryState()) {
    fetchData();
  }

  Future<void> fetchData() async {
    emit(LoadingCategoryState());
    categoryiList = await _getCatogoriesUseCase.call();

    // 🔹 push to stream as well
    _categoriesController.add(categoryiList);

    if (categoryiList.isEmpty) {
      emit(EmptyCategoryState());
    } else {
      emit(DoneCategoryState(categoryiList));
    }
  }

  void addCategory(String name) async {
    await _addCatogoriesUseCase(params: CategoryEntity(name: name));
    emit(NotifeyCategoryState("تم"));
    await fetchData();
  }

  void updateCategory(int id, String name) async {
    await _updateCatogoriesUseCase(params: CategoryEntity(name: name, id: id));
    emit(NotifeyCategoryState("تم"));
    await fetchData();
  }

  void search(String query) async {
    final filteredCategories = categoryiList
        .where((category) => category.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredCategories.isEmpty) {
      emit(NoResultCategoryState());
    } else {
      emit(DoneCategoryState(filteredCategories));
    }
  }

  void deleteCategory(int id) async {
    await _deleteCatogoriesUseCase.call(params: id);
    emit(NotifeyCategoryState("تم"));
    await fetchData();
  }

  void fetchEsnadsData() async {
    emit(LoadingCategoryState());
    List<EsnadEntity> categoryiList = await _getallEsnadUseCase.call();
    emit(DoneEsnadsState(categoryiList));
  }

  @override
  Future<void> close() {
    _categoriesController.close();
    return super.close();
  }
}
