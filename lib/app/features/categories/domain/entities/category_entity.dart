import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int? id;
  final String? name;
  final List<DhkarEntity>? dhkars;

  const CategoryEntity({
    this.dhkars,
    this.id,
    this.name,
  });

  @override
  List<Object?> get props {
    return [id, name, dhkars];
  }
}
