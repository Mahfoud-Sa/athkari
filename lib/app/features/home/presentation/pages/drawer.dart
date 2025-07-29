import 'dart:async';
import 'dart:ui';
import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/features/home/data/model/release_model.dart';
import 'package:athkari/app/features/home/presentation/cubit/drawer_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/drawer_cubit_status.dart';
import 'package:athkari/app/features/home/presentation/widgets/DrawerTitleWidet.dart';
import 'package:athkari/app/features/home/presentation/widgets/ForwardedTitleWidget.dart';
import 'package:athkari/app/features/home/presentation/widgets/MyExpansionRadioTile.dart';
import 'package:athkari/app/features/home/presentation/widgets/drawer_app_bar_widget.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui; 



class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool _value = false;
  
  @override
  Widget build(BuildContext context) {
     // Watch appVersion once here:
    final appVersion = context.watch<DrawerCubit>().appVersion;
    return Drawer(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //custome app bar
            DrawerAppBar(),
           
           
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
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: Text("الغاء")),
                      //okey button
                      TextButton(
                          onPressed: () async {
                            try {
                              final appDataBaseServices =
                                  getIt.get<AppDataBaseServices>();

                              await appDataBaseServices.esnadDao.seedEsnads();
                              await appDataBaseServices.categoryDao
                                  .seedCategory();
                              await appDataBaseServices.adhkaiDao.seedAdhkars();

                              Navigator.pop(context);

                              // Optional: Show success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('تم اعاده ضبط الاذكار')),
                              );
                            } catch (e) {
                              // Handle errors
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Error: ${e.toString()}')),
                              );
                            }
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
           BlocListener<DrawerCubit, DrawerCubitState>(
                listener: (BuildContext context, DrawerCubitState state) async {
                    if (state is CheckUpdatesState) {
                      // Show loading indicator
                      showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
                    } 
                  else if (state is UpdateAvailableState) {
                   
                    _showUpdateAlert(context,state.releaseModel);
                  } 
                 else if (state is NoUpdateState) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
  if (context.mounted) {
  try {
    showOkayAlert(context,state.message) ; } catch (e) {
    debugPrint('Error showing dialog: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ في عرض التنبيه')),
      );
    }
  }
}
}
    else if (state is CheckUpdateErrorState) {
      // Dismiss any loading dialog
    //  Navigator.of(context).pop();
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage)),
      );
    }
  },
  child: ForwardedTitleWidget(
    title: 'تحقق من التحديثات',
    onPressed: () {
      context.read<DrawerCubit>().checkUpdate();
    },
  ),
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
            SizedBox(
              height: 30,
            ),

            Center(
  child: GestureDetector(
    onTap: () {
      // context.read<DrawerCubit>().checkVersion();
    },
    child: appVersion != null
        ? Text(
            'v$appVersion الإصدار',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
            textAlign: TextAlign.center,
          )
        : CircularProgressIndicator(),
  ),
)

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
                  padding:  EdgeInsets.only(right: 8.0),
                  child:  Text(
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


void _showUpdateAlert(BuildContext context, ReleaseModel release) {
  final dateFormat = DateFormat('yyyy/MM/dd'); // Date formatter
  final size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
       // textDirection: TextDirection.RTL,
        textDirection:ui.TextDirection.rtl,
        child: AlertDialog(
          title: Text(
            'تحديث جديد متاح',
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Version Info
                Text(
                  'الإصدار: ${release.tagName}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                
                // Release Date
                Text(
                  'تاريخ النشر: ${dateFormat.format(release.publishedAt)}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 12),
                
                // Release Notes
                if (release.body.isNotEmpty) ...[
                  Text(
                    'ملاحظات الإصدار:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  Text(
                    release.body,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                ],
                
                // Download Instructions
                Text(
                  "اضغط على زر التحديث لبدء تنزيل الإصدار الجديد",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.start,
          actions: <Widget>[
            TextButton(
              child: Text('الغاء'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: Text('تحديث الآن'),
              onPressed: () async {
                if (release.assets.isNotEmpty) {
                  final url = release.assets.first.browserDownloadUrl;
                  if (!await launchUrl(Uri.parse(url))) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('فشل فتح رابط التحديث')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

void _showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
}
void showOkayAlert(BuildContext context, String message) {
  final size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: ui.TextDirection.rtl,
        child: AlertDialog(
          title: const Text(
            'تنبيه',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: SizedBox(
            width: size.width * 0.8,
            child: Text(
              message,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'موافق',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.end,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    },
  );
}