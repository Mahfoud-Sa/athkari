// category_details_cubit.dart
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_to_dailywered_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/delete_dekhair_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogory_details_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/update_dekhar_with_esnade_usecase.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_details_cubit_states.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_dekhar_with_esnade_usecase.dart';
import 'package:bloc/bloc.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  final GetCatogoryDetailsUseCase _getCatogoryDetailsUseCase;
  final AddDekharWithEsnadUsecase _addDekharWithEsnadUsecase;
  final AddToDailyweredUsecase _addToDailyweredUsecase;
  final UpdateDekharWithEsnadUsecase _updateToDailyweredUsecase;
  final DeleteDekharUseCase _deleteDekharUseCase;
  int? _currentCategoryId;
  CategoryDetailsCubit(
    this._getCatogoryDetailsUseCase,
    this._addDekharWithEsnadUsecase, this._addToDailyweredUsecase, this._deleteDekharUseCase, this._updateToDailyweredUsecase,
  ) : super(InitialCategoryDetailsState());

Future<void> fetchCategoryDetails(int id) async {
  _currentCategoryId = id; // Store the ID for future operations
  emit(LoadingCategoryDetailsState());
  
  try {
    final categoryDetails = await _getCatogoryDetailsUseCase.call(params: id);
    
    // Null and empty checks with better readability
    if (categoryDetails == null || 
        categoryDetails.dhkars == null || 
        categoryDetails.dhkars!.isEmpty) {
      emit(EmptyCategoryDetailsState());
    } else {
      emit(DoneCategoryDetailsState(categoryDetails));
    }
    
  } catch (e) {
    // More detailed error message with actual error
    emit(ErrorCategoryDetailsState("حدث خطأ أثناء جلب التفاصيل: ${e.toString()}"));
    
    // Consider adding error logging here
    // debugPrint('Error fetching category details: $e');
  }
}

  Future<void> addDekharWithEsnad(
      int categoryId, int esnadId, String dekharText) async {
    emit(LoadingCategoryDetailsState());
    try {
      await _addDekharWithEsnadUsecase.call(params: (
        categoryId,
        DhkarModel(dhkar: dekharText, esnad: EsnadModel(id: esnadId))
      ));
      emit(NotifyCategoryDetailsState("تمت الإضافة بنجاح"));
      await fetchCategoryDetails(categoryId);
    } catch (e) {
      emit(ErrorCategoryDetailsState("حدث خطأ أثناء الإضافة"));
    }
  }
    Future<void> addToDailyWered(int dekharId,int repetition) async {
    _addToDailyweredUsecase.call(params:(dekharId,repetition));
  }


 Future<void> deleteDekhar(int dekharId) async {
  try {
  //  emit(LoadingCategoryDetailsState()); // Show loading state
    
    final result = await _deleteDekharUseCase.call(params: dekharId);
    
    if (!result) {
      emit(DeleteErrorCategoryDetailsState("حدث خطأ أثناء الحذف"));
    } else {
      emit(NotifyCategoryDetailsState("تم الحذف بنجاح"));
     // Refresh the data after successful deletion
      
    }
    if (_currentCategoryId != null) {
        await fetchCategoryDetails(_currentCategoryId!);
      }
  } catch (e) {
    emit(DeleteErrorCategoryDetailsState("حدث خطأ غير متوقع: ${e.toString()}"));
  }
}
   Future<void> updateDekhar(int dekharId,String dekhar,int esnadId) async {
    
   _updateToDailyweredUsecase.call(params: (_currentCategoryId!, DhkarModel(id:dekharId ,dhkar: dekhar, esnad: EsnadModel(id: esnadId))));
    emit(NotifyCategoryDetailsState("تم التعديل بنجاح"));
    if (_currentCategoryId != null) {
      await fetchCategoryDetails(_currentCategoryId!);
    }
  }
}