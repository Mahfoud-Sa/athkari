
import 'package:athkari/app/features/home/presentation/cubit/daily_wered_cubit_status.dart';
import 'package:bloc/bloc.dart';

class DailyWeredCubit_ extends Cubit<DailyWeredCubitStatus_> {
  //final GetCatogoriesUseCase _getCatogoriesUseCase;
  //final ResetDatabaseUsecase _resetDatabaseUsecase;
  //List<CategoryEntity> categoriesList = [];

  DailyWeredCubit_() : super(InitDailyWeredState_())  {
    emit(DoneDailyWeredState_(30,50,40));
    //fetchData();
   
  }
}
 
  