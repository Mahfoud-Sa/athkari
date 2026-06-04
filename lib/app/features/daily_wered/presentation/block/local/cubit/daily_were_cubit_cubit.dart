import 'package:athkari/app/features/daily_wered/domain/usecase/add_dhaker_usecase.dart';
import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/delete_daily_wered_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/done_daily_wered_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/get_daily_wered.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/update_daily_wered_repetation_usecase%20copy.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_state.dart';
import 'package:bloc/bloc.dart';

class DailyWereCubit extends Cubit<DailyWeredCubitStates> {
  final GetDailyWereUseCase _dailyWereUseCase;
  final AddDhakerUseCase _addDhakerUseCase;
  final DoneDailyWeredUsecase _dailyWeredUsecase;
  final UpdateDailyWeredRepetationUsecase _updateDailyWeredRepetationUsecase;
  final DeleteDailyWeredUsecase _deleteDailyWeredUsecase;
  List<DailyWeredModel> daily_wered_list = [];
  //final GetTotalDailyWereUseCase _getTotalDailyWereUseCase;
  DailyWereCubit(
      this._dailyWereUseCase,
      this._addDhakerUseCase,
      this._dailyWeredUsecase,
      this._updateDailyWeredRepetationUsecase,
      this._deleteDailyWeredUsecase)
      //  this._getTotalDailyWereUseCase
      : super(InitialDailyWeredState()) {
    emit(LoadingDailyWeredState());
    FetchData();
  }

  void FetchData() async {
    try {
      daily_wered_list = await _dailyWereUseCase.call();
      if (daily_wered_list.isEmpty) {
        emit(EmptyDailyWeredDataState(message: "لاتوجد بيانات"));
      } else {
        emit(DoneDailyWeredState(athkari: daily_wered_list));
      }
    } catch (error) {
      emit(NotifeyDailyWeredCubitState(error.toString()));
    }
    // emit(DoneDailyWeredState(athkari: athkariList));
  }

  void Search(String query) async {
    // var athkariList = await _dailyWereUseCase.call();
    final result = daily_wered_list
        .where((x) => x.dhkar?.contains(query) ?? false)
        .toList();
    if (result.isEmpty) {
      emit(EmptyDailyWeredDataState(message: "لاتوجد بيانات"));
    } else {
      emit(DoneDailyWeredState(athkari: result));
    }
  }

  void doneDekher(int id) async {
    // var athkariList = await _dailyWereUseCase.call();
    await _dailyWeredUsecase.call(params: id);
    FetchData();
    // emit(DoneDailyWeredState(athkari: daily_wered_list));
  }

  void deleteDekher(int id) async {
    // var athkariList = await _dailyWereUseCase.call();
    print(id);
    await _deleteDailyWeredUsecase.call(params: id);
    FetchData();
    // emit(DoneDailyWeredState(athkari: daily_wered_list));
  }

  void updateRepetation(int id, int repetation) async {
    // var athkariList = await _dailyWereUseCase.call();
    await _updateDailyWeredRepetationUsecase.call(
        params: id, repatation: repetation);
    FetchData();
    // emit(DoneDailyWeredState(athkari: daily_wered_list));
  }
  // void GetTotalOfDekeers() async {
  //   var total = await _getTotalDailyWereUseCase.call();

  //   emit(DoneState(athkari: athkariList));
  // }

  void AddDheker(String text_1, String test_2) async {
    await _addDhakerUseCase.call();

    emit(DoneDailyWeredState(athkari: []));
  }
}
