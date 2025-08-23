import 'package:athkari/app/features/home/data/model/daily.dart';
import 'package:athkari/app/features/home/domain/entity/daily_wered_progress_entity.dart';
import 'package:athkari/app/features/home/domain/usecase/fetch_daily_wered_usecase.dart';
import 'package:athkari/app/features/home/presentation/cubit/daily_wered_cubit_status.dart';
import 'package:bloc/bloc.dart';

class DailyWeredProgressCubit extends Cubit<DailyWeredCubitStatus> {
  final FetchDailyWeredUsecase _fetchDailyWeredUsecase;

  DailyWeredProgressCubit(this._fetchDailyWeredUsecase)
      : super(InitDailyWeredState()) {
    // Don't call fetchData() in constructor to avoid immediate API calls
    // You can call it manually when needed
  }

  // Initialize data (call this when you want to load data initially)
  Future<void> initialize() async {
  //   await Future.delayed(Duration(seconds: 30));
  //  emit( ErrorDailyWeredState("sadfasdfasd".toString()));
    await fetchData();
  }

  Future<void> fetchData() async {
   
    // Don't emit loading if we're already in loading state
    if (state is! LoadingDailyWeredState) {
    //  Future.delayed(Duration(seconds: 3)); // Simulate delay
      emit(LoadingDailyWeredState());
    }
    
    try {
      final DailyWeredProgressEntity result = await _fetchDailyWeredUsecase();
      
      // Fix: Check for division by zero and handle null values
      final totalWered = result.totalWered ?? 0;
      final completedWered = result.compeletedWered ?? 0;
      
      double percentage = 0.0;
      if (totalWered > 0) {
        percentage = (completedWered / totalWered) * 100;
      }
      
      // Fix: Use the correct state class (DoneDailyWeredState instead of DoneDailyWeredState_)
      emit(DoneDailyWeredState(
        percentage,
        totalWered,
        completedWered,
        "سبحان الله والحمدلله \nولا اله  الا الله والله أكبر"
      ));
      
    } catch (error) {
      // Handle errors properly
      emit(ErrorDailyWeredState(error.toString()));
    }
  }

  Future<void> refresh() async {
    emit(LoadingDailyWeredState());
    try {
      final DailyWeredProgressEntity result = await _fetchDailyWeredUsecase();
      
      final totalWered = result.totalWered ?? 0;
      final completedWered = result.compeletedWered ?? 0;
      
      double percentage = 0.0;
      if (totalWered > 0) {
        percentage = (completedWered / totalWered) * 100;
      }
      
      emit(DoneDailyWeredState(
        percentage,
        totalWered,
        completedWered,
        "سبحان الله والحمدلله \nولا اله  الا الله والله أكبر"
      ));
      
    } catch (error) {
      emit(ErrorDailyWeredState(error.toString()));
    }
  }

  // Reset to initial state if needed
  void reset() {
    emit(InitDailyWeredState());
  }
}