import 'package:athkari/app/features/categories/domain/entities/category.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

class EsnadModel extends EsnadEntity {
  final int? id;
  final String? name;

  EsnadModel({this.id, this.name});

  factory EsnadModel.fromDataBase(Map<String, dynamic> map) {
    return EsnadModel(id: map['id'] ?? "", name: map['name'] ?? "");
  }
  factory EsnadModel.fromEntity(CategoryEntity entity) {
    return EsnadModel(id: entity.id, name: entity.name);
  }
  // Convert an object to JSON (opposite function)
  Map<String, dynamic> toJson() {
    return {
      //'id': id,
      'name': name,
    };
  }
}
