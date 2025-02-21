import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_category_with_esnade_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/delete_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/update_catogories_usecase.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/get_all_esnad_usecase.dart';
import 'package:bloc/bloc.dart';

class CategoryCubit extends Cubit<CatogeryState> {
  final GetCatogoriesUseCase _getCatogoriesUseCase;
  final AddCatogoriesUseCase _addCatogoriesUseCase;
  final UpdateCatogoriesUseCase _updateCatogoriesUseCase;
  final DeleteCatogoriesUseCase _deleteCatogoriesUseCase;
  final GetAllEsnadUseCase _getallEsnadUseCase;
  final AddDekharWithEsnadUsecase _addDekharWithEsnadUsecase;
  List<CategoryEntity> categoryiList = [];

  CategoryCubit(
      this._getCatogoriesUseCase,
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

  void fetchCategoryDetails(int id) async {
    await _deleteCatogoriesUseCase.call(params: id);
    emit(LoadingCategoryState());
    await Future.delayed(Duration(seconds: 1));
    emit(DoneCategoryDetailsState(categoryiList[1]));
    // FetchData();
  }

  void fetchEsnadsData() async {
    emit(LoadingCategoryState());
    List<EsnadEntity> categoryiList = await _getallEsnadUseCase.call();
    // final List<EsnadEntity> esnads = [
    //   EsnadEntity(id: 1, name: "asdf"),
    //   EsnadEntity(id: 1, name: "google"),
    //   EsnadEntity(id: 1, name: "youtube"),
    //   EsnadEntity(id: 1, name: "amazopn"),
    //   EsnadEntity(id: 1, name: "asddf"),
    //   EsnadEntity(id: 1, name: "asdsf"),
    //   EsnadEntity(id: 1, name: "aasdf"),
    //   EsnadEntity(id: 1, name: "asdrf"),
    //   EsnadEntity(id: 1, name: "asd_f"),
    // ];
    //  await _deleteCatogoriesUseCase.call(params: id);

    // await Future.delayed(Duration(seconds: 1));
    emit(DoneEsnadsState(categoryiList));
    //   FetchData();
  }

  void addDekharWithEsnad(
      int categoryId, int EsnadId, String DekharText) async {
    var temp = _addDekharWithEsnadUsecase.call(params: (
      categoryId,
      DhkarModel(dhkar: DekharText, esnad: EsnadModel(id: EsnadId))
    ));
    print(temp);
    print("hgauf dvd] hsrh' hgkh;lkasjdf;laksjdf;lashd;fjh");
    emit(LoadingCategoryState());
    // categoryiList = await _getallEsnadUseCase.call();
    // final List<EsnadEntity> esnads = [
    //   EsnadEntity(id: 1, name: "asdf"),
    //   EsnadEntity(id: 1, name: "google"),
    //   EsnadEntity(id: 1, name: "youtube"),
    //   EsnadEntity(id: 1, name: "amazopn"),
    //   EsnadEntity(id: 1, name: "asddf"),
    //   EsnadEntity(id: 1, name: "asdsf"),
    //   EsnadEntity(id: 1, name: "aasdf"),
    //   EsnadEntity(id: 1, name: "asdrf"),
    //   EsnadEntity(id: 1, name: "asd_f"),
    // ];
    //  await _deleteCatogoriesUseCase.call(params: id);

    // await Future.delayed(Duration(seconds: 1));
    FetchData();
    //   FetchData();
  }
}
