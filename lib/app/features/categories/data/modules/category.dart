import 'package:athkari/app/features/categories/domain/entities/category.dart';

class CategoryModel extends CategoryEntity {
  final int? id;
  final String? name;

  CategoryModel({this.id, this.name});

  factory CategoryModel.fromDataBase(Map<String, dynamic> map) {
    return CategoryModel(id: map['id'] ?? "", name: map['name'] ?? "");
  }
  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(id: entity.id, name: entity.name);
  }
  // Convert an object to JSON (opposite function)
  Map<String, dynamic> toJson() {
    return {
      //'id': id,
      'name': name,
    };
  }
}
