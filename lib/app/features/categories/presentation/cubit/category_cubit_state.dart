import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
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

class DoneCategoryDetailsState extends CatogeryState {
  final CategoryEntity catogory;

  DoneCategoryDetailsState(this.catogory);

  @override
  // TODO: implement props
  List<Object?> get props => [catogory]; // For state comparison
}

class DoneEsnadsState extends CatogeryState {
  final List<EsnadEntity> EsandsList;

  DoneEsnadsState(this.EsandsList);

  @override
  // TODO: implement props
  List<Object?> get props => [EsandsList]; // For state comparison
}

class EmptyCategoryState extends CatogeryState {
  final String message;
  EmptyCategoryState(this.message);

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

class NotifeyCategoryState extends CatogeryState {
  final String message;
  NotifeyCategoryState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message]; // For state comparison
}
