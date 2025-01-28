import 'package:athkari/app/features/daily_wered/domain/usecase/add_dhaker_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/get_daily_wered.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_state.dart';
import 'package:bloc/bloc.dart';

class DailyWereCubit extends Cubit<DailyWeredCubitStates> {
  final GetDailyWereUseCase _dailyWereUseCase;
  final AddDhakerUseCase _addDhakerUseCase;
  var athkariList;
  //final GetTotalDailyWereUseCase _getTotalDailyWereUseCase;
  DailyWereCubit(this._dailyWereUseCase, this._addDhakerUseCase)
      //  this._getTotalDailyWereUseCase
      : super(InitialDailyWeredState()) {
    emit(LoadingDailyWeredState());
    FetchData();
  }

  void FetchData() async {
    athkariList = await _dailyWereUseCase.call();
    if (athkariList.length == 0) {
      emit(EmptyDailyWeredDataState(message: "لاتوجد بيانات"));
    } else {
      emit(DoneDailyWeredState(athkari: athkariList));
    }
    // emit(DoneDailyWeredState(athkari: athkariList));
  }

  void Search(String query) async {
    // var athkariList = await _dailyWereUseCase.call();
    athkariList =
        athkariList.where((x) => x["dhaker"].contains(query)).toList();
    emit(DoneDailyWeredState(athkari: athkariList));
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
