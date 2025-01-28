import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_catogories_use_case.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_use_case.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/add_esnade_usecase.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/delete_esnad_usecase.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/get_all_esnad_usecase.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/update_esnade_usecase.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit_state.dart';
import 'package:athkari/app/features/home/presentation/cubit/home_page_cubit_states.dart';
import 'package:bloc/bloc.dart';

class HomepageCubit extends Cubit<HomePageCubitStates> {
  final GetCatogoriesUseCase _getCatogoriesUseCase;

  List<CategoryEntity> categoriesList = [];

  HomepageCubit(this._getCatogoriesUseCase) : super(InitialHomePageState()) {
    emit(LoadingHomePageState());
    fetchData();
  }

  void fetchData() async {
    categoriesList = await _getCatogoriesUseCase.call();
    if (categoriesList.length == 0) {
      emit(EmptyHomePageState("لاتوجد بيانات"));
    } else {
      emit(DoneHomePageState(categoriesList));
    }
  }

  // void addEsnad(String name) async {
  //   await _addEsnadeUsecase(params: EsnadEntity(name: name));
  //   emit(NotifeyEsnadState("تم"));
  //   fetchData();
  // }

  // void deleteEsnad(int esnadId) async {
  //   await _deleteEsnadeUsecase(params: esnadId);
  //   emit(NotifeyEsnadState("تم"));
  //   fetchData();
  // }

  // void updateEsnad(int id, String name) async {
  //   await _updateEsnadeUsecase(params: EsnadEntity(id: id, name: name));
  //   emit(NotifeyEsnadState("تم"));
  //   fetchData();
  // }

  // void search(String query) async {
  //   esnadsList =
  //       esnadsList = esnadsList.where((x) => x.name!.contains(query)).toList();
  //   if (esnadsList.length == 0) {
  //     emit(EmptyEsnadState("لاتوجد نتيجة لبحثك"));
  //   } else {
  //     emit(DoneEsnadState(esnadsList));
  //   }
  // }
}
