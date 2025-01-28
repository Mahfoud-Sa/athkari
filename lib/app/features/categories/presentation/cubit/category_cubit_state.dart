import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CatogeryState extends Equatable {}

class InitialCategoryState extends CatogeryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingCategoryState extends CatogeryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DoneCategoryState extends CatogeryState {
  final List<CategoryEntity> catogories;

  DoneCategoryState(this.catogories);

  @override
  // TODO: implement props
  List<Object?> get props => [catogories]; // For state comparison
}

class EmptyCategoryState extends CatogeryState {
  EmptyCategoryState();

  @override
  // TODO: implement props
  List<Object?> get props => []; // For state comparison
}

class ErrorCategoryState extends CatogeryState {
  final String message;
  ErrorCategoryState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message]; // For state comparison
}
