import 'package:athkari/app/features/categories/domain/entities/category.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_catogories_use_case.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_use_case.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit_state.dart';
import 'package:bloc/bloc.dart';

class EsnadsCubit extends Cubit<EsnadState> {
  // final GetCatogoriesUseCase _getCatogoriesUseCase;
  // final AddCatogoriesUseCase _addCatogoriesUseCase;
  List<EsnadEntity> esnads = [];

  EsnadsCubit() : super(InitialEsnadState()) {
    emit(LoadingEsnadState());
    FetchData();
  }

  void FetchData() async {
    esnads = [
      EsnadEntity(
        id: 1,
        name: """أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ
اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ. [آية الكرسى - البقرة 255]. """,
      )
    ];
    //await _getCatogoriesUseCase.call();

    emit(DoneEsnadState(esnads));
  }
}
//   void AddCategory(String name) async {
//    // await _addCatogoriesUseCase(params: CategoryEntity(name: name));

//     FetchData();
//   }

//   void Loading() async {
//     emit(LoadingCategoryState());
//   }

//   void Search(String query) async {
//     var result = categoryiList =
//         categoryiList.where((x) => x.name!.contains(query)).toList();
//     if (result.length == 0) {
//       emit(EmptyCategoryState());
//     } else {
//       emit(DoneCategoryState(result));
//     }
//   }
// }
