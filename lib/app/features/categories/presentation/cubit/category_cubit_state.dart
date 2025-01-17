import 'package:athkari/app/features/categories/domain/entities/category.dart';
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
