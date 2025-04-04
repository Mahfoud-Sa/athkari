import 'package:athkari/app/features/daily_wered/domain/usecase/add_dhaker_usecase.dart';
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
  var daily_wered_list;
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
    daily_wered_list = await _dailyWereUseCase.call();
    if (daily_wered_list.length == 0) {
      emit(EmptyDailyWeredDataState(message: "لاتوجد بيانات"));
    } else {
      emit(DoneDailyWeredState(athkari: daily_wered_list));
    }
    // emit(DoneDailyWeredState(athkari: athkariList));
  }

  void Search(String query) async {
    // var athkariList = await _dailyWereUseCase.call();
    daily_wered_list =
        daily_wered_list.where((x) => x["dhaker"].contains(query)).toList();
    emit(DoneDailyWeredState(athkari: daily_wered_list));
  }

  void doneDekher(int id) async {
    // var athkariList = await _dailyWereUseCase.call();
    _dailyWeredUsecase.call(params: id);
    FetchData();
    // emit(DoneDailyWeredState(athkari: daily_wered_list));
  }

  void deleteDekher(int id) async {
    // var athkariList = await _dailyWereUseCase.call();
    print(id);
    _deleteDailyWeredUsecase.call(params: id);
    FetchData();
    // emit(DoneDailyWeredState(athkari: daily_wered_list));
  }

  void updateRepetation(int id, int repetation) async {
    // var athkariList = await _dailyWereUseCase.call();
    _updateDailyWeredRepetationUsecase.call(params: id, repatation: repetation);
    FetchData();
    // emit(DoneDailyWeredState(athkari: daily_wered_list));
  }
  // void GetTotalOfDekeers() async {
  //   var total = await _getTotalDailyWereUseCase.call();

  //   emit(DoneState(athkari: athkariList));
  // }

  void AddDheker(String text_1, String test_2) async {
    var athkariList = await _addDhakerUseCase.call();

    emit(DoneDailyWeredState(athkari: []));
  }
}
