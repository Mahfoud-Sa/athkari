import 'package:equatable/equatable.dart';

abstract class CatogeryState extends Equatable {}

class InitialState extends CatogeryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NoDataState extends CatogeryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingState extends CatogeryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DoneState extends CatogeryState with EquatableMixin {
  final List<Map<String, dynamic>> athkari;
  final int total;

  // Constructor
  DoneState({required this.athkari})
      : total = athkari.isEmpty ? 0 : athkari.length;

  @override
  List<Object?> get props => [athkari, total]; // For state comparison
}
