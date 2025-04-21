import 'package:equatable/equatable.dart';

class DailyWeredProgressEntity extends Equatable {
  final int? compeletedWered;
  final int? totalWered;
  
  const DailyWeredProgressEntity({this.compeletedWered, this.totalWered});

  @override
  List<Object?> get props {
    return [compeletedWered, totalWered ];
  }
}
