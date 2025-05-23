import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_category_with_esnade_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/delete_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogory_details_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/update_catogories_usecase.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/get_all_esnad_usecase.dart';
import 'package:bloc/bloc.dart';

class CategoryCubit extends Cubit<CatogeryState> {
  final GetCatogoriesUseCase _getCatogoriesUseCase;
  final GetCatogoryDetailsUseCase _getCatogoryDetailsUseCase;
  final AddCatogoriesUseCase _addCatogoriesUseCase;
  final UpdateCatogoriesUseCase _updateCatogoriesUseCase;
  final DeleteCatogoriesUseCase _deleteCatogoriesUseCase;
  final GetAllEsnadUseCase _getallEsnadUseCase;
  final AddDekharWithEsnadUsecase _addDekharWithEsnadUsecase;
  List<CategoryEntity> categoryiList = [];

  CategoryCubit(
      this._getCatogoriesUseCase,
      this._getCatogoryDetailsUseCase,
      this._addCatogoriesUseCase,
      this._updateCatogoriesUseCase,
      this._deleteCatogoriesUseCase,
      this._getallEsnadUseCase,
      this._addDekharWithEsnadUsecase)
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

  fetchCategoryDetails(int id) async {
    CategoryEntity? categoryDetails;
    categoryDetails = await _getCatogoryDetailsUseCase.call(params: id);
    categoryDetails == null
        ? emit(EmptyCategoryState(""))
        : emit(DoneCategoryDetailsState(categoryDetails!));
    
  }

  void fetchEsnadsData() async {
    emit(LoadingCategoryState());
    List<EsnadEntity> categoryiList = await _getallEsnadUseCase.call();
    
    emit(DoneEsnadsState(categoryiList));
   
  }

  void addDekharWithEsnad(
      int categoryId, int EsnadId, String DekharText) async {
    var temp = _addDekharWithEsnadUsecase.call(params: (
      categoryId,
      DhkarModel(dhkar: DekharText, esnad: EsnadModel(id: EsnadId))
    ));
    print(temp);
   
    emit(LoadingCategoryState());
    fetchCategoryDetails(categoryId);
    
  }
}
