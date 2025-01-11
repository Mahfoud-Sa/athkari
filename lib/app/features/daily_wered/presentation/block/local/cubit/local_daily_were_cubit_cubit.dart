import 'package:athkari/app/features/daily_wered/domain/repository/dhkar_repository.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/get_daily_wered.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/local_daily_were_cubit_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LocalDailyWereCubitCubit extends Cubit<LocalDailyWeredCubitStates> {
  final GetDailyWereUseCase _dailyWereUseCase;
  LocalDailyWereCubitCubit(this._dailyWereUseCase) : super(InitialState()) {
    emit(NoDataState());
    //emit(DoneState(athkari: athkariList));
    // FetchData();
  }

  void FetchData() async {
    var athkariList = await _dailyWereUseCase.call();

    emit(DoneState(athkari: athkariList));
  }
}
