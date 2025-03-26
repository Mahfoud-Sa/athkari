import 'package:athkari/app/features/daily_wered/domain/entities/daily_wered_entity.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';

class DailyWeredModel extends DailyWeredEntity {
  final int? id;
  final String? dhkar;
  final int? repetitions;
  final EsnadModel? esnad;

  DailyWeredModel({
    this.id,
    this.dhkar,
    this.repetitions,
    this.esnad,
  });

  factory DailyWeredModel.fromDataBase(Map<String, dynamic> map) {
    return DailyWeredModel(
        id: map['id'] ?? 0,
        dhkar: map['dhaker'] ?? "",
        repetitions: map['repetitions'] ?? 0,
        esnad: EsnadModel.fromDataBase(map));
  }
  // factory DailyWeredModel.fromDataBase_1(Map<String, dynamic> map) {
  //   return DailyWeredModel(
  //     // id: int.parse(map['id'] ?? 0),
  //     dhkar: map['dhaker'] ?? "",
  //     // repetitions: int.parse(map["repetitions"] ?? 0),
  //     esnad: EsnadModel(
  //         // id: int.parse(map['id'] ?? 0),
  //         name: map['name'] ?? ""),
  //   );
  // }
  Map<String, dynamic> toDatabse() {
    return {
      'id': id,
      'dhkar': dhkar,
      'repetitions': repetitions,
      'esnad': esnad!.toDatabse(), // Added the missing comma here
    };
  }

  // factory DailyWeredModel.fromEntity(DhkarEntity entity) {
  //   return DailyWeredModel(
  //       id: entity.id,
  //       dhkar: entity.dhkar,
  //       esnad: EsnadModel.fromEntity(entity.esnad!));
  // }
}
