abstract class DailyWeredCubitStatus {}

class InitDailyWeredState extends DailyWeredCubitStatus {}

class LoadingDailyWeredState extends DailyWeredCubitStatus {}

class DoneDailyWeredState extends DailyWeredCubitStatus {
  final double percentage;
  final int totalWered;
  final int completedWered;
  final String message;
  
  DoneDailyWeredState(this.percentage, this.totalWered, this.completedWered, this.message);
}

class ErrorDailyWeredState extends DailyWeredCubitStatus {
  final String message;
  ErrorDailyWeredState(this.message);
}