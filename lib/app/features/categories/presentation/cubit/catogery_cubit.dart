import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/daily_wered/domain/repository/dhkar_repository.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/add_dhaker_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/get_daily_wered.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/update_daily_wered_usecase.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/local_daily_were_cubit_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class CatogeryCubit extends Cubit<CatogeryState> {
  final GetDailyWereUseCase _dailyWereUseCase;
  final AddDhakerUseCase _addDhakerUseCase;
  var athkariList;
  //final GetTotalDailyWereUseCase _getTotalDailyWereUseCase;
  CatogeryCubit(this._dailyWereUseCase, this._addDhakerUseCase)
      //  this._getTotalDailyWereUseCase
      : super(InitialState()) {
    emit(NoDataState());
    //emit(DoneState(athkari: athkariList));
    // FetchData();
  }

  void FetchData() async {
    athkariList = await _dailyWereUseCase.call();

    emit(DoneState(athkari: athkariList));
  }

  void Search(String query) async {
    // var athkariList = await _dailyWereUseCase.call();
    athkariList =
        athkariList.where((x) => x["dhaker"].contains(query)).toList();
    emit(DoneState(athkari: athkariList));
  }
  // void GetTotalOfDekeers() async {
  //   var total = await _getTotalDailyWereUseCase.call();

  //   emit(DoneState(athkari: athkariList));
  // }

  void AddDheker(String text_1, String test_2) async {
    var athkariList = await _addDhakerUseCase.call();

    emit(DoneState(athkari: []));
  }
}
