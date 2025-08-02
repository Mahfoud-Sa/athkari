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
   
    fetchData();
  }

  void fetchData() async {
    emit(LoadingCategoryState());
    categoryiList = await _getCatogoriesUseCase.call();
    if(categoryiList.isEmpty){
      emit(EmptyCategoryState("لا توجد اي تصفيفات اذكر جرب كتابة تصنيفك الخاص,او اعد ضبط الاذكار من الاعدادات"));
    }
    emit(DoneCategoryState(categoryiList));
  }

  void addCategory(String name) async {
    await _addCatogoriesUseCase(params: CategoryEntity(name: name));
    emit(NotifeyCategoryState("تم"));
    
    fetchData();
  }

  void updateCategory(int id, String name) async {
    await _updateCatogoriesUseCase(params: CategoryEntity(name: name, id: id));
    emit(NotifeyCategoryState("تم"));
    
    fetchData();
  }

 

  void search(String query) async {
   

      final filteredCategories = categoryiList
        .where((category) => category.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredCategories.isEmpty) {
      emit(EmptyCategoryState("لا توجد نتيجة لبحثك جرب البحث باستخدام كلمات اخرئ ..."));
    } else {
      emit(DoneCategoryState(filteredCategories));
    }
  }

  void deleteCategory(int id) async {
    await _deleteCatogoriesUseCase.call(params: id);
    emit(NotifeyCategoryState("تم"));
    fetchData();
  }

  // fetchCategoryDetails(int id) async {
  //   CategoryEntity? categoryDetails;
  //   categoryDetails = await _getCatogoryDetailsUseCase.call(params: id);
  //   categoryDetails == null
  //       ? emit(EmptyCategoryState(""))
  //       : emit(DoneCategoryDetailsState(categoryDetails!));
    
  // }

  void fetchEsnadsData() async {
    emit(LoadingCategoryState());
    List<EsnadEntity> categoryiList = await _getallEsnadUseCase.call();
    
    emit(DoneEsnadsState(categoryiList));
   
  }

  // void addDekharWithEsnad(
  //     int categoryId, int EsnadId, String DekharText) async {
  //   var temp = _addDekharWithEsnadUsecase.call(params: (
  //     categoryId,
  //     DhkarModel(dhkar: DekharText, esnad: EsnadModel(id: EsnadId))
  //   ));
  //   print(temp);
   
  //   emit(LoadingCategoryState());
  //   fetchCategoryDetails(categoryId);
    
  // }
}
