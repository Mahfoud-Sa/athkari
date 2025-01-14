import 'package:equatable/equatable.dart';

abstract class LocalDailyWeredCubitStates extends Equatable {}

class InitialState extends LocalDailyWeredCubitStates {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NoDataState extends LocalDailyWeredCubitStates {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingState extends LocalDailyWeredCubitStates {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DoneState extends LocalDailyWeredCubitStates with EquatableMixin {
  final List<Map<String, dynamic>> athkari;
  final int total;

  // Constructor
  DoneState({required this.athkari})
      : total = athkari.isEmpty ? 0 : athkari.length;

  @override
  List<Object?> get props => [athkari, total]; // For state comparison
}
