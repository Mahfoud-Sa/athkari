 class DrawerCubitState {}
class CheckUpdatesState extends DrawerCubitState {}
class UpdateAvailableState extends DrawerCubitState {
  final String link;
  UpdateAvailableState(this.link);
}
class NoUpdateState extends DrawerCubitState {
  final String message;
  NoUpdateState(this.message);
}
class CheckUpdateErrorState extends DrawerCubitState {
  final String errorMessage;
  CheckUpdateErrorState(this.errorMessage);
}