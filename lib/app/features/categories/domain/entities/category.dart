import 'package:athkari/app/features/daily_wered/domain/entities/dhkar.dart';
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int? id;
  final String? name;
  const CategoryEntity({
    this.id,
    this.name,
  });

  // ignore: avoid_types_as_parameter_names
  // factory CategoryEntity.fromJson(Map<String, dynamic> json) {
  //   return CategoryEntity();
  // }

  @override
  // TODO: implement props
  List<Object?> get props {
    return [id, name];
  }
}
