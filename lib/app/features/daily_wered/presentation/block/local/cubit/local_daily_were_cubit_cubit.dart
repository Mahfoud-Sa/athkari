import 'package:athkari/app/features/daily_wered/domain/repository/dhkar_repository.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/add_dhaker_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/get_daily_wered.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/get_total_daily_wered.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/local_daily_were_cubit_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LocalDailyWereCubitCubit extends Cubit<LocalDailyWeredCubitStates> {
  final GetDailyWereUseCase _dailyWereUseCase;
  final AddDhakerUseCase _addDhakerUseCase;
  final GetTotalDailyWereUseCase _getTotalDailyWereUseCase;
  LocalDailyWereCubitCubit(this._dailyWereUseCase, this._addDhakerUseCase,
      this._getTotalDailyWereUseCase)
      : super(InitialState()) {
    emit(NoDataState());
    //emit(DoneState(athkari: athkariList));
    // FetchData();
  }

  void FetchData() async {
    var athkariList = await _dailyWereUseCase.call();

    emit(DoneState(athkari: athkariList));
  }

  void GetTotalOfDekeers() async {
    var athkariList = await _getTotalDailyWereUseCase.call();

    emit(DoneState(athkari: athkariList));
  }

  void AddDheker(String text_1, String test_2) async {
    var athkariList = await _addDhakerUseCase.call();

    emit(DoneState(athkari: []));
  }
}
