import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/local_daily_were_cubit_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LocalDailyWereCubitCubit extends Cubit<LocalDailyWeredCubitStates> {
  LocalDailyWereCubitCubit() : super(InitialState()) {
    emit(LoadingState());
  }
}
