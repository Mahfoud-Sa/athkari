import 'dart:ui';

import 'package:athkari/app/features/home/presentation/widgets/DrawerTitleWidet.dart';
import 'package:athkari/app/features/home/presentation/widgets/ForwardedTitleWidget.dart';
import 'package:athkari/app/features/home/presentation/widgets/MyExpansionRadioTile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

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
                showAboutDialog(context: context);
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
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: const Text(
                'ضبط الاشعارات',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
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
                        fontSize: 18,
                        color: Color.fromARGB(255, 157, 199, 168)),
                  ),
                )
              ],
            ),
            TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Color.fromARGB(255, 213, 240, 193)),
              highlightedTextStyle: TextStyle(
                  fontSize: 24, color: Color.fromARGB(255, 128, 188, 189)),
              spacing: 50,
              itemHeight: 80,
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
                        fontSize: 18,
                        color: Color.fromARGB(255, 157, 199, 168)),
                  ),
                )
              ],
            ),
            TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle: TextStyle(
                  fontSize: 24, color: Color.fromARGB(255, 157, 199, 168)),
              highlightedTextStyle:
                  TextStyle(fontSize: 24, color: Colors.blueGrey),
              spacing: 50,
              itemHeight: 80,
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  // _dateTime = time;
                });
              },
            ),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
