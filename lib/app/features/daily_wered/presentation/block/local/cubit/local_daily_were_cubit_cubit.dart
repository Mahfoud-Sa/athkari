import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'local_daily_were_cubit_state.dart';

class LocalDailyWereCubitCubit extends Cubit<LocalDailyWereCubitState> {
  LocalDailyWereCubitCubit() : super(LocalDailyWereCubitInitial());
}
