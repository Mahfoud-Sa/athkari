import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';

class DhkarModel extends DhkarEntity {
  final int? id;
  final String? dhkar;
  final int? repetitions;
  final EsnadModel? esnad;

  DhkarModel({
    this.id,
    this.dhkar,
    this.repetitions,
    this.esnad,
  });

  factory DhkarModel.fromDataBase(Map<String, dynamic> map) {
    return DhkarModel(
        id: map['id'] ?? "",
        dhkar: map['name'] ?? "",
        esnad: EsnadModel.fromDataBase(map));
  }
  Map<String, dynamic> toDatabse() {
    return {
      'id': id,
      'dhkar': dhkar,
      'repetitions': repetitions,
      'esnad': esnad!.toDatabse(), // Added the missing comma here
    };
  }

  // factory DhkarModel.fromEntity(EsnadEntity entity) {
  //   return DhkarModel(id: entity.id, name: entity.name);
  // }
}
