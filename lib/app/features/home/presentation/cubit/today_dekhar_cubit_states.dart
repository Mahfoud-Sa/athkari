import 'package:equatable/equatable.dart';

abstract class TodayDekharCubitStates extends Equatable {}
class InitialTodayDekharState extends TodayDekharCubitStates {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class doneDekkharState extends TodayDekharCubitStates {
  final String message;
  doneDekkharState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message]; // For state comparison
}

class waitingDekkharState extends TodayDekharCubitStates {
  
  waitingDekkharState();
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}