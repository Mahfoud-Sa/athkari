import 'package:athkari/app/features/categories/domain/entities/category.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_catogories_use_case.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_use_case.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/add_esnade_usecase.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/get_all_usecase.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit_state.dart';
import 'package:bloc/bloc.dart';

class EsnadsCubit extends Cubit<EsnadState> {
  final GetAllEsnadUseCase _getAllEsnadUseCase;
  final AddEsnadeUsecase _addEsnadeUsecase;
  List<EsnadEntity> esnads = [];

  EsnadsCubit(this._getAllEsnadUseCase, this._addEsnadeUsecase)
      : super(InitialEsnadState()) {
    emit(LoadingEsnadState());
    FetchData();
  }

  void FetchData() async {
    esnads = await _getAllEsnadUseCase.call();
    if (esnads.length == 0) {
      emit(EmptyEsnadState("لاتوجد بيانات"));
    } else {
      emit(DoneEsnadState(esnads));
    }
  }

  void AddEsnad(String name) async {
    await _addEsnadeUsecase(params: EsnadEntity(name: name));

    FetchData();
  }
}
//   void Loading() async {
//     emit(LoadingCategoryState());
//   }

//   void Search(String query) async {
//     var result = categoryiList =
//         categoryiList.where((x) => x.name!.contains(query)).toList();
//     if (result.length == 0) {
//       emit(EmptyCategoryState());
//     } else {
//       emit(DoneCategoryState(result));
//     }
//   }
// }
