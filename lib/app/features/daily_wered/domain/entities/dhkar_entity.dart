import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

class DhkarEntity {
  final int? id;
  final String? dhkar;
  final int? repetitions;
  final EsnadEntity? esnad;

  DhkarEntity({this.esnad, this.id, this.dhkar, this.repetitions});
}
