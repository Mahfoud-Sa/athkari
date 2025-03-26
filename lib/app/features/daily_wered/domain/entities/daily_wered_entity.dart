import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

class DailyWeredEntity {
  final int? id;
  final String? dhkar;
  final int? repetitions;
  final EsnadEntity? esnad;

  DailyWeredEntity({this.esnad, this.id, this.dhkar, this.repetitions});
}
