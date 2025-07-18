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
