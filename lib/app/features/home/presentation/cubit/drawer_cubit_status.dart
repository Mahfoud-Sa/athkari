import 'package:equatable/equatable.dart';

abstract class DrawerCubitState extends Equatable {}

class InitialDrawerPageState extends DrawerCubitState {
  InitialDrawerPageState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CheckUpdatesState extends DrawerCubitState {
  //final List<CategoryEntity> categories;
  // final String message;

  CheckUpdatesState();

  @override
  // TODO: implement props
  List<Object?> get props => []; // For
}

class NoUpdateState extends DrawerCubitState {
  final String message;
  // final String message;

  NoUpdateState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => []; // For
}

class UpdateAvailableState extends DrawerCubitState {
  final String version;

  UpdateAvailableState(this.version);

  @override
  // TODO: implement props
  List<Object?> get props => [version]; // For
}

class DoneUpdateState extends DrawerCubitState {
  //final List<CategoryEntity> categories;
  // final String message;

  DoneUpdateState();

  @override
  // TODO: implement props
  List<Object?> get props => []; // For
}
