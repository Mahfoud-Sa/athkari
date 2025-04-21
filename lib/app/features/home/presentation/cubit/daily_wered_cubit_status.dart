import 'package:equatable/equatable.dart';

abstract class DailyWeredCubitStatus_ extends Equatable {}

class InitDailyWeredState_ extends DailyWeredCubitStatus_ {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class DoneDailyWeredState_ extends DailyWeredCubitStatus_ {
 final int daily_wered_presentage;
 final int total_wered;
 final int compeleted_wered;

  DoneDailyWeredState_(this.daily_wered_presentage,this.compeleted_wered,this.total_wered);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class EmptyDailyWeredState_ extends DailyWeredCubitStatus_ {
  final String message;
  EmptyDailyWeredState_(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];// For state comparison
}
class LoadingDailyWeredState_ extends DailyWeredCubitStatus_ {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
