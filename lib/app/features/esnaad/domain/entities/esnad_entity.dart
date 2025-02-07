import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:equatable/equatable.dart';

class EsnadEntity extends Equatable {
  final int? id;
  final String? name;
  final List<DhkarEntity>? dekarsList;
  const EsnadEntity({this.id, this.name, this.dekarsList});

  @override
  List<Object?> get props {
    return [id, name, dekarsList];
  }
}
