import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HomePageCubitStates extends Equatable {}

class InitialHomePageState extends HomePageCubitStates {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingHomePageState extends HomePageCubitStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DoneHomePageState extends HomePageCubitStates {
  final List<CategoryEntity> categories;
  // final String message;

  DoneHomePageState(this.categories);

  @override
  // TODO: implement props
  List<Object?> get props => [categories]; // For state comparison
}

class EmptyHomePageState extends HomePageCubitStates {
  final String message;
  EmptyHomePageState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => []; // For state comparison
}

class NotifeyHomePageState extends HomePageCubitStates {
  final String message;
  NotifeyHomePageState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message]; // For state comparison
}
