import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';

class DhkarModel extends DhkarEntity {
  final int? id;
  final String? dhkar;
  int? repetitions;
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
        dhkar: map['dhaker'] ?? "",
        esnad: EsnadModel.fromDataBase(map));
  }
factory DhkarModel.fromDataBase_1(Map<String, dynamic> map) {
  return DhkarModel(
    id: map['adhkar_id'],  // Use aliased adhkar_id
    dhkar: map['dhaker'] ?? "",
    esnad: EsnadModel(
      id: map['esnad_id'],  // Use aliased esnad_id
      name: map['esnad_name'] ?? "",  // Use aliased esnad_name
    ),
  );
}
  Map<String, dynamic> toDatabse() {
    return {
      'id': id,
      'dhkar': dhkar,
      'repetitions': repetitions,
      'esnad': esnad!.toDatabse(), // Added the missing comma here
    };
  }

  factory DhkarModel.fromEntity(DhkarEntity entity) {
    return DhkarModel(
        id: entity.id,
        dhkar: entity.dhkar,
        esnad: EsnadModel.fromEntity(entity.esnad!));
  }
}
