import 'dart:ui';

import 'package:athkari/app/core/app_database.dart';
import 'package:athkari/app/features/home/presentation/widgets/DrawerTitleWidet.dart';
import 'package:athkari/app/features/home/presentation/widgets/ForwardedTitleWidget.dart';
import 'package:athkari/app/features/home/presentation/widgets/MyExpansionRadioTile.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
// import 'package:rating/rating.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage("assets/images/patteren.png"))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // First widget aligned to the right
                  const SizedBox(
                    width: 50,
                  ),
                  // Second widget centered
                  Text(
                    'إعدادات التطبيق',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white, fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).closeDrawer();
                        },
                        icon: SvgPicture.asset('assets/svgs/back_button.svg'),
                      );
                    }),
                  ),
                ],
              ),
            ),
            DrawerTitleWidet(
              title: 'إعدادات التطبيق',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      dragStartBehavior: DragStartBehavior.start,
                      splashRadius: 250,
                      activeColor: const Color.fromARGB(255, 157, 199, 168),
                      value: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = !_value;
                        });
                      }),
                  Text(
                    'الوضع الليلي',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black),
                  )
                ],
              ),
            ),
            MyExpansionRadioTile(
              title: 'ضبط الوقت والتاريخ',
              selected: true,
              choices: ['تلقائي', 'مخصص'],
            ),
            MyExpansionRadioTile(
              title: 'لغة التطبيق',
              selected: true,
              choices: ['إنجليزي', 'عربي'],
            ),
            DrawerTitleWidet(
              title: 'إعدادات الإذكار',
            ),
            MyExpansionRadioTile(
              title: 'ضبط الورد اليومي',
              selected: true,
              choices: const ['غير مفعل', 'مفعل'],
            ),
            ForwardedTitleWidget(
              title: 'ضبط الاشعارات',
              onPressed: () {
                buildShowModalBottomSheet(context);
              },
            ),
            ForwardedTitleWidget(
              title: 'إعاده ضبط الاذكار',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actionsAlignment: MainAxisAlignment.end,
                    alignment: Alignment.centerRight,
                    title: Text("إعاده ضبط الاذكار"),
                    content: Text(
                        "سيتم اعاده ضبط الاذكار في التطبيق الى الاعدادات الافتراضية"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("الغاء")),
                      TextButton(
                          onPressed: () async {
                            var _AppDataBaseServices =
                                await getIt.get<AppDataBaseServices>();
                            //_AppDataBaseServices.db.
                            _AppDataBaseServices.categoryDao.seedCategory();
                            _AppDataBaseServices.esnadDao.seedEsnads();
                            await _AppDataBaseServices.adhkaiDao.seedAdhkars();
                          },
                          child: Text("موافق")),
                    ],
                  ),
                );
              },
            ),
            DrawerTitleWidet(
              title: 'أخرى',
            ),
            ForwardedTitleWidget(
              title: 'مشاركة التطبيق',
              onPressed: () {
                Share.share('check out my website https://example.com');
              },
            ),
            ForwardedTitleWidget(
              title: 'تقييم التطبيق',
              onPressed: () {
                // showModalBottomSheet(
                //   context: context,
                //   builder: (context) => RatingWidget(
                //       controller: PrintRatingController(ratingModel)),
                // );
              },
            ),
            ForwardedTitleWidget(
              title: 'تواصل معنا',
              onPressed: () {
                showAboutDialog(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        //  width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 3,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 12),
              child: Text(
                'ضبط الاشعارات',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: const Text(
                    'حدد موعد ظهور اشعارات الورد اليومي',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Color.fromARGB(255, 128, 188, 189)),
                  ),
                )
              ],
            ),
            TimePickerSpinner(
              is24HourMode: false,
              alignment: Alignment.centerRight,
              normalTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Color.fromARGB(255, 213, 240, 193)),
              highlightedTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Color.fromARGB(255, 128, 188, 189)),
              //spacing: 50,
              //itemHeight: 80,
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  // _dateTime = time;
                });
              },
            ),
            // EasyDateTimeLine(
            //   initialDate: DateTime.now(),
            // ),
            // EasyDateTimeLine(
            //   initialDate: DateTime.now(),
            //   onDateChange: (selectedDate) {
            //     //`selectedDate` the new date selected.
            //   },
            // ),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: const Text(
                    'حدد موعد ظهور اشعارات ورد اليوم',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Color.fromARGB(255, 128, 188, 189)),
                  ),
                )
              ],
            ),
            TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Color.fromARGB(255, 213, 240, 193)),
              highlightedTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Color.fromARGB(255, 128, 188, 189)),
              // spacing: 50,
              // itemHeight: 80,
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  // _dateTime = time;
                });
              },
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                child: Center(
                  child: const Text(
                    'ضبط الاشعارات',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 128, 188, 189),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 300,
                height: 50,
                child: const Center(
                  child: Text(
                    'الغاء',
                    style: TextStyle(
                        color: Color.fromARGB(255, 128, 188, 189),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 128, 188, 189),
                        width: 3),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

// class PrintRatingController extends RatingController {
//   PrintRatingController(RatingModel ratingModel) : super(ratingModel);

//   @override
//   Future<void> ignoreForEverCallback() async {
//     print('Rating ignored forever!');
//     await Future.delayed(const Duration(seconds: 3));
//   }

//   @override
//   Future<void> saveRatingCallback(
//       int rate, List<RatingCriterionModel> selectedCriterions) async {
//     print('Rating saved!\nRate: $rate\nsSelectedItems: $selectedCriterions');
//     await Future.delayed(const Duration(seconds: 3));
//   }
// }

// final ratingModel = RatingModel(
//   id: 1,
//   title: null,
//   subtitle: 'Classifique nosso app:',
//   ratingConfig: RatingConfigModel(
//     id: 1,
//     ratingSurvey1: 'Em que podemos melhorar?',
//     ratingSurvey2: 'Em que podemos melhorar?',
//     ratingSurvey3: 'Em que podemos melhorar?',
//     ratingSurvey4: 'Em que podemos melhorar?',
//     ratingSurvey5: 'O que você mais gostou?',
//     items: [
//       RatingCriterionModel(id: 1, name: 'Qualidade do atendimento'),
//       RatingCriterionModel(id: 2, name: 'Competência dos atendentes'),
//       RatingCriterionModel(id: 3, name: 'Limpeza do ambiente'),
//       RatingCriterionModel(id: 4, name: 'Tempo de espera'),
//     ],
//   ),
// );
