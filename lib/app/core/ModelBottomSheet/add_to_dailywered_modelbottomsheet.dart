
  import 'package:athkari/app/core/widgets/minus_button_widget.dart';
import 'package:athkari/app/core/widgets/plus_button_widget%20copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// ✅ Bottom sheet for editing repetitions
  Future<dynamic> buildAddtoDailyweredModalBottomSheet(BuildContext context) {
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
                'اضافه الى الورد اليومي',
                style: TextStyle(
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
                    'ضبط عدد مرات الذكر',
                    style: TextStyle(
                      color:Color(0xFF80BCBD), // Using your color value
                      fontWeight: FontWeight.w400,
                      fontFamily: "IBMPlexSansArabic",
                      fontStyle:  FontStyle.normal,
                      fontSize: 16.0),

                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
               PlusButtonWidget(),
               MinusButtonWidget()
             ],
           ),
           SizedBox(height: 10,),
            InkWell(
              onTap: () {
                // Add your edit logic here
                Navigator.pop(context);
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
                  'اضافه',
                  style: TextStyle(
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
                      color:   Color(0xff3a3a3a),
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
