import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:equatable/equatable.dart';

abstract class DailyWeredCubitStates extends Equatable {}

class InitialDailyWeredState extends DailyWeredCubitStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadingDailyWeredState extends DailyWeredCubitStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DoneDailyWeredState extends DailyWeredCubitStates {
  final List<DailyWeredModel> athkari;

  // Constructor
  DoneDailyWeredState({required this.athkari});

  @override
  List<Object?> get props => [athkari]; // For state comparison
}

class EmptyDailyWeredDataState extends DailyWeredCubitStates {
  final String message;

  EmptyDailyWeredDataState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NotifeyDailyWeredCubitState extends DailyWeredCubitStates {
  final String message;
  NotifeyDailyWeredCubitState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message]; // For state comparison
}
