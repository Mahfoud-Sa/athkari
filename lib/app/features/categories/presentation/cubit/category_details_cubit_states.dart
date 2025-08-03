// category_details_state.dart

import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';

abstract class CategoryDetailsState {}

class InitialCategoryDetailsState extends CategoryDetailsState {}

class LoadingCategoryDetailsState extends CategoryDetailsState {}

class DoneCategoryDetailsState extends CategoryDetailsState {
  final CategoryEntity categoryDetails;
  DoneCategoryDetailsState(this.categoryDetails);
}

class ErrorCategoryDetailsState extends CategoryDetailsState {
  final String message;
  ErrorCategoryDetailsState(this.message);
}
class EmptyCategoryDetailsState extends CategoryDetailsState {
  
  EmptyCategoryDetailsState();
}
class NotifyCategoryDetailsState extends CategoryDetailsState {
  final String message;
  NotifyCategoryDetailsState(this.message);
}