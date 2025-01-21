import 'package:athkari/app/features/categories/domain/entities/category.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:equatable/equatable.dart';

abstract class EsnadState extends Equatable {}

class InitialEsnadState extends EsnadState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingEsnadState extends EsnadState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DoneEsnadState extends EsnadState {
  final List<EsnadEntity> esnads;

  DoneEsnadState(this.esnads);

  @override
  // TODO: implement props
  List<Object?> get props => [esnads]; // For state comparison
}

class EmptyEsnadStateState extends EsnadState {
  EmptyEsnadStateState();

  @override
  // TODO: implement props
  List<Object?> get props => []; // For state comparison
}

// class ErrorCategoryState extends CatogeryState {
//   final String message;
//   ErrorCategoryState(this.message);

//   @override
//   // TODO: implement props
//   List<Object?> get props => [message]; // For state comparison
// }
