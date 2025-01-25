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
  List<EsnadEntity> esnadsList = [];

  EsnadsCubit(this._getAllEsnadUseCase, this._addEsnadeUsecase)
      : super(InitialEsnadState()) {
    emit(LoadingEsnadState());
    fetchData();
  }

  void fetchData() async {
    esnadsList = await _getAllEsnadUseCase.call();
    if (esnadsList.length == 0) {
      emit(EmptyEsnadState("لاتوجد بيانات"));
    } else {
      emit(DoneEsnadState(esnadsList));
    }
  }

  void addEsnad(String name) async {
    await _addEsnadeUsecase(params: EsnadEntity(name: name));
    emit(NotifeyEsnadState("تم"));
    fetchData();
  }

  void search(String query) async {
    esnadsList =
        esnadsList = esnadsList.where((x) => x.name!.contains(query)).toList();
    if (esnadsList.length == 0) {
      emit(EmptyEsnadState("لاتوجد نتيجة لبحثك"));
    } else {
      emit(DoneEsnadState(esnadsList));
    }
  }
}
//   void Loading() async {
//     emit(LoadingCategoryState());
//   }

  

