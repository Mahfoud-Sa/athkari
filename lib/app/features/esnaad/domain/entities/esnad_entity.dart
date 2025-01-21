import 'package:athkari/app/features/daily_wered/domain/entities/dhkar.dart';
import 'package:equatable/equatable.dart';

class EsnadEntity extends Equatable {
  final int? id;
  final String? name;
  const EsnadEntity({
    this.id,
    this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props {
    return [id, name];
  }
}
