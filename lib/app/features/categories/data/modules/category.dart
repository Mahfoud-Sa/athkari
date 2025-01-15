import 'package:athkari/app/features/categories/domain/entities/category.dart';

class CategoryModel extends CategoryEntity {
  final int? id;
  final String? name;

  CategoryModel({this.id, this.name});

  factory CategoryModel.fromDataBase(Map<String, dynamic> map) {
    return CategoryModel(id: map['id'] ?? "", name: map['name'] ?? "");
  }
}
