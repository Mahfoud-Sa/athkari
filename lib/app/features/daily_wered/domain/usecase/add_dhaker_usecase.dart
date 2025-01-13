import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';

class AddDhakerUseCase implements UseCase {
  final DhkarRepositoryImpl _dhkarRepository;
  AddDhakerUseCase(this._dhkarRepository);
  @override
  Future<bool> call({params}) async {
    // TODO: implement call
    return await _dhkarRepository.addDhkars(
        "اللّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلاً مُتَقَبَّلاً.",
        5);
  }
}
