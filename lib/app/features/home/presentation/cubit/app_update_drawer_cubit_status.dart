 import 'package:athkari/app/features/home/data/model/release_model.dart';

class AppUpdateCubitState {
  get darkModeEnabled => false;
}
class CheckUpdatesState extends AppUpdateCubitState {}
class UpdateAvailableState extends AppUpdateCubitState {
  final ReleaseModel releaseModel;
  UpdateAvailableState(this.releaseModel);
}
class NoUpdateState extends AppUpdateCubitState {
  final String message;
  NoUpdateState(this.message);
}
class CheckUpdateErrorState extends AppUpdateCubitState {
  final String errorMessage;
  CheckUpdateErrorState(this.errorMessage);
}