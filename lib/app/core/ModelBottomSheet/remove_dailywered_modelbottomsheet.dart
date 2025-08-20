 import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ✅ Bottom sheet for delete confirmation
  Future<dynamic> buildShowRemoveDekeerBottomSheet(BuildContext context,int dekharId) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
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
                "ازاله من الورد اليومي",
                style:  TextStyle(
                  color:   Color(0xff3a3a3a),
                  fontWeight: FontWeight.w600,
                  fontFamily: "IBMPlexSansArabic",
                  fontStyle:  FontStyle.normal,
                  fontSize: 20.0
              ),
              ),
            ),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    'هل انت متاكد من ازاله هذا الذكر من الورد اليومي؟',
                    style:   TextStyle(
                      color:Color(0xFF80BCBD), // Using your color value
                      fontWeight: FontWeight.w400,
                      fontFamily: "IBMPlexSansArabic",
                      fontStyle:  FontStyle.normal,
                      fontSize: 16.0
                  ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                // Add your delete logic here
                context.read<DailyWereCubit>().deleteDekher(dekharId);
                // Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF80BCBD),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'ازاله الذكر',
                  style:  TextStyle(
                    color:  Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: "IBMPlexSansArabic",
                    fontStyle:  FontStyle.normal,
                    fontSize: 16.0
                ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 300,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF80BCBD),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'الغاء',
                  style:  TextStyle(
                    color:Color(0xFF80BCBD), // Using your color valu,
                    fontWeight: FontWeight.w400,
                    fontFamily: "IBMPlexSansArabic",
                    fontStyle:  FontStyle.normal,
                    fontSize: 16.0
                ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
