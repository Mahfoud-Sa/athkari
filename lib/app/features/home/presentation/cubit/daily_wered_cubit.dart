
import 'package:athkari/app/features/home/data/model/daily.dart';
import 'package:athkari/app/features/home/domain/entity/daily_wered_progress_entity.dart';
import 'package:athkari/app/features/home/domain/usecase/fetch_daily_wered_usecase.dart';
import 'package:athkari/app/features/home/presentation/cubit/daily_wered_cubit_status.dart';
import 'package:bloc/bloc.dart';

class DailyWeredCubit_ extends Cubit<DailyWeredCubitStatus_> {
  final FetchDailyWeredUsecase _fetchDailyWeredUsecase;
  //final ResetDatabaseUsecase _resetDatabaseUsecase;
  //List<CategoryEntity> categoriesList = [];

  DailyWeredCubit_(this._fetchDailyWeredUsecase) : super(InitDailyWeredState_())  {
   
    fetchData();
   
  }

  fetchData()async{
   emit(LoadingDailyWeredState_());
   DailyWeredProgressEntity result= await _fetchDailyWeredUsecase();
   Future.delayed(Duration(seconds: 10),() {
      int presentage=50;
   emit(DoneDailyWeredState_(presentage,result.totalWered!,result.compeletedWered!));
   },);
  
  }

}
 
  