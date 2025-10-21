import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

class DhkarEntity {
  final int? id;
  final String? dhkar;
  final int? repetitions;
  final EsnadEntity? esnad;
  final bool inDailyWered;
  DhkarEntity(
      {this.inDailyWered = false,
      this.esnad,
      this.id,
      this.dhkar,
      this.repetitions});
}
