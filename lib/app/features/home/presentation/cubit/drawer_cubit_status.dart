 import 'package:athkari/app/features/home/data/model/release_model.dart';

class DrawerCubitState {}
class CheckUpdatesState extends DrawerCubitState {}
class UpdateAvailableState extends DrawerCubitState {
  final ReleaseModel releaseModel;
  UpdateAvailableState(this.releaseModel);
}
class NoUpdateState extends DrawerCubitState {
  final String message;
  NoUpdateState(this.message);
}
class CheckUpdateErrorState extends DrawerCubitState {
  final String errorMessage;
  CheckUpdateErrorState(this.errorMessage);
}