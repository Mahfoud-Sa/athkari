import 'package:equatable/equatable.dart';

abstract class DrawerCubitState extends Equatable {}

class InitialDrawerPageState extends DrawerCubitState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CheckUpdatesState extends DrawerCubitState {
  //final List<CategoryEntity> categories;
  // final String message;

  CheckUpdatesState();

  @override
  // TODO: implement props
  List<Object?> get props => []; // For
}
