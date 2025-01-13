import 'package:athkari/app/features/daily_wered/data/datasources/app_database.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar.dart';
import 'package:athkari/app/features/daily_wered/domain/repository/dhkar_repository.dart';

class DhkarRepositoryImpl implements DhkarRepository {
  final AppDataBaseServices _appDataBaseServices;

  DhkarRepositoryImpl(this._appDataBaseServices);

  @override
  List<Map<String, dynamic>> getAllDhkars() {
    {
      var temp = _appDataBaseServices.adhkaiDao.getAllAdhkai();
      print(temp);
      //  print(_appDataBaseServices.getAll()
      return [
        {
          "deker": """أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ
اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ. [آية الكرسى - البقرة 255]. """,
          "saneed":
              "من قالها حين يصبح أجير من الجن حتى يمسى ومن قالها حين يمسى أجير من الجن حتى يصبح.",
          "no_of_repeating": 4
        },
        {
          "deker":
              """بِسْمِ اللهِ الَّذِي لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الأَرْضِ وَلاَ فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ.""",
          "saneed": "من قالها ثلاثاً لم يضره شيء في ذلك اليوم.",
          "no_of_repeating": 3
        },
        {
          "deker":
              """رَضِيتُ بِاللهِ رَبًّا وَبِالإِسْلاَمِ دِينًا وَبِمُحَمَّدٍ نَبِيًّا.""",
          "saneed": "من قالها ثلاثاً كان حقاً على الله أن يرضيه.",
          "no_of_repeating": 3
        },
        {
          "deker":
              """اللّهُمَّ أَنْتَ رَبِّي لاَ إِلَهَ إِلاَّ أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ لَكَ بِذَنْبِي فَاغْفِرْ لِي، فَإِنَّهُ لاَ يَغْفِرُ الذُّنُوبَ إِلاَّ أَنْتَ.""",
          "saneed": "من قالها صباحاً ومساءً ومات دخل الجنة.",
          "no_of_repeating": 1
        },
        {
          "deker":
              """اللّهُمَّ عَافِنِي فِي بَدَنِي، اللّهُمَّ عَافِنِي فِي سَمْعِي، اللّهُمَّ عَافِنِي فِي بَصَرِي. لاَ إِلَهَ إِلاَّ أَنْتَ.""",
          "saneed": "يستحب قولها ثلاثاً صباحاً ومساءً.",
          "no_of_repeating": 3
        },
        {
          "deker":
              """اللّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْكُفْرِ وَالْفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ. لاَ إِلَهَ إِلاَّ أَنْتَ.""",
          "saneed": "يقال صباحاً ومساءً ثلاث مرات.",
          "no_of_repeating": 3
        },
        {
          "deker":
              """اللّهُمَّ اجْعَلْ فِي قَلْبِي نُورًا، وَفِي لِسَانِي نُورًا، وَفِي سَمْعِي نُورًا، وَفِي بَصَرِي نُورًا، وَمِنْ فَوْقِي نُورًا، وَمِنْ تَحْتِي نُورًا، وَعَنْ يَمِينِي نُورًا، وَعَنْ شِمَالِي نُورًا.""",
          "saneed": "دعاء طلب النور والهداية.",
          "no_of_repeating": 1
        },
        {
          "deker":
              """اللّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلاً مُتَقَبَّلاً.""",
          "saneed": "يقال بعد صلاة الفجر.",
          "no_of_repeating": 1
        },
        {
          "deker": """سُبْحَانَ اللهِ وَبِحَمْدِهِ.""",
          "saneed": "من قالها مئة مرة حطت عنه خطاياه ولو كانت مثل زبد البحر.",
          "no_of_repeating": 100
        },
        {
          "deker":
              """اللّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ زَوَالِ نِعْمَتِكَ، وَتَحَوُّلِ عَافِيَتِكَ، وَفُجَاءَةِ نِقْمَتِكَ، وَجَمِيعِ سَخَطِكَ.""",
          "saneed": "دعاء يحفظ الإنسان من الشرور.",
          "no_of_repeating": 1
        },
        {
          "deker":
              """اللّهُمَّ أَنْتَ رَبِّي، لاَ إِلَهَ إِلاَّ أَنْتَ، عَلَيْكَ تَوَكَّلْتُ وَأَنْتَ رَبُّ الْعَرْشِ الْعَظِيمِ.""",
          "saneed": "دعاء للتوكل على الله.",
          "no_of_repeating": 1
        }
      ];
    }
  }

  @override
  Future<bool> addDhkars(String dheer, String esnaad) {
    return _appDataBaseServices.adhkaiDao.Insert(dheer, esnaad);
  }
}
