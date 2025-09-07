import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_to_dailywered_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_usecase.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/add_esnade_usecase.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/delete_esnad_usecase.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/get_all_esnad_usecase.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/update_esnade_usecase.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit_state.dart';
import 'package:bloc/bloc.dart';

class EsnadsCubit extends Cubit<EsnadState> {
  final GetAllEsnadUseCase _getAllEsnadUseCase;
  final AddEsnadeUsecase _addEsnadeUsecase;
  final UpdateEsnadeUsecase _updateEsnadeUsecase;
  final DeleteEsnadeUsecase _deleteEsnadeUsecase;
  List<EsnadEntity> esnadsList = [];

  EsnadsCubit(this._getAllEsnadUseCase, this._addEsnadeUsecase,
      this._updateEsnadeUsecase, this._deleteEsnadeUsecase)
      : super(InitialEsnadState()) {
    emit(LoadingEsnadState());
    fetchData();
  }

  void fetchData() async {
    esnadsList = await _getAllEsnadUseCase.call();
    if (esnadsList.isEmpty) {
      emit(EmptyEsnadState("لاتوجد بيانات"));
    } else {
      emit(DoneEsnadState(esnadsList));
    }
  }

  void addEsnad(String name) async {
    await _addEsnadeUsecase(params: EsnadEntity(name: name));
    emit(NotifeyEsnadState("تم اضافة الاسناد"));
    fetchData();
  }

  void deleteEsnad(int esnadId) async {
    await _deleteEsnadeUsecase(params: esnadId);
    emit(NotifeyEsnadState("تم حذف الاسناد"));
    fetchData();
  }

  void updateEsnad(int id, String name) async {
    await _updateEsnadeUsecase(params: EsnadEntity(id: id, name: name));
    emit(NotifeyEsnadState("تم تعديل الاسناد"));
    fetchData();
  }

  void search(String query) async {
    esnadsList =
        esnadsList = esnadsList.where((x) => x.name!.contains(query)).toList();
    if (esnadsList.isEmpty) {
      emit(EmptyEsnadState("لاتوجد نتيجة لبحثك"));
    } else {
      emit(DoneEsnadState(esnadsList));
    }
  }
}
