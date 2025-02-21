// lib/features/daily_reading/domain/usecases/get_daily_reading_progress.dart
import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/repository/dhkar_repository.dart';

class GetDailyReadingProgress implements UseCase<void, void> {
  final DhkarRepository repository;

  GetDailyReadingProgress(this.repository);

  @override
  Future<void> call({params}) async {
    return await repository.dailyDhkarProgress();
  }
}
