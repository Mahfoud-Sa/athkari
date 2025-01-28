import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';

class CategoryModel extends CategoryEntity {
  final int? id;
  final String? name;
  final List<DhkarModel>? dhkars;
  CategoryModel({this.id, this.name, this.dhkars});

  factory CategoryModel.fromDataBase(Map<String, dynamic> map) {
    var dhkarsFromJson = map['dhkars'] as List<dynamic>?;
    List<DhkarModel>? dhkarsList = dhkarsFromJson
        ?.map((dhkarJson) => DhkarModel.fromDataBase(dhkarJson))
        .toList();
    return CategoryModel(
        id: map['id'] ?? "", name: map['name'] ?? "", dhkars: dhkarsList ?? []);
  }
  // factory CategoryModel.fromEntity(CategoryEntity entity) {
  //   return CategoryModel(id: entity.id, name: entity.name,dhkars: entity.dhkars);
  // }

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'name': name,
      'dhkars': dhkars?.map((dhkar) => dhkar.toDatabse()).toList(),
    };
  }
}
