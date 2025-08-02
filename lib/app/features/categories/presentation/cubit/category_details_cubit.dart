// category_details_cubit.dart
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogory_details_usecase.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_details_cubit_states.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_category_with_esnade_usecase.dart';
import 'package:bloc/bloc.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  final GetCatogoryDetailsUseCase _getCatogoryDetailsUseCase;
  final AddDekharWithEsnadUsecase _addDekharWithEsnadUsecase;

  CategoryDetailsCubit(
    this._getCatogoryDetailsUseCase,
    this._addDekharWithEsnadUsecase,
  ) : super(InitialCategoryDetailsState());

  Future<void> fetchCategoryDetails(int id) async {
    emit(LoadingCategoryDetailsState());
    try {
      final categoryDetails = await _getCatogoryDetailsUseCase.call(params: id);
      if (categoryDetails == null) {
        emit(ErrorCategoryDetailsState("لا يمكن العثور على تفاصيل التصنيف"));
      } else {
        emit(DoneCategoryDetailsState(categoryDetails));
      }
    } catch (e) {
      emit(ErrorCategoryDetailsState("حدث خطأ أثناء جلب التفاصيل"));
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
}