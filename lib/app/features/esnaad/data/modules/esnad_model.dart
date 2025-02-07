import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

class EsnadModel extends EsnadEntity {
  final int? id;
  final String? name;
  final List<DhkarModel>? dekarsList;

  const EsnadModel({this.id, this.name, this.dekarsList})
      : super(id: id, name: name);

  factory EsnadModel.fromDataBase(Map<String, dynamic> map) {
    var dekarsListFromJson = map['Esnads'] as List<dynamic>?;
    List<DhkarModel>? dekarsList = dekarsListFromJson
        ?.map((dhkarJson) => DhkarModel.fromDataBase(dhkarJson))
        .toList();

    return EsnadModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      dekarsList: dekarsList,
    );
  }

  Map<String, dynamic> toDatabse() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory EsnadModel.fromEntity(EsnadEntity entity) {
    return EsnadModel(id: entity.id, name: entity.name);
  }
}
