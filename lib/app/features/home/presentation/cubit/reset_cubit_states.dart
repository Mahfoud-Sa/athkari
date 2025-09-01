 import 'package:athkari/app/features/home/data/model/release_model.dart';

class ResetCubitState {
  get darkModeEnabled => false;
}
class InitState extends ResetCubitState {
  
  InitState();
}
class WaitingState extends ResetCubitState {
  
  WaitingState();
}
class DoneState extends ResetCubitState {
  
  DoneState();
}