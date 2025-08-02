import 'package:flutter/material.dart';

Widget emptyDataWidget({bool smallSize = false}) {
  if (smallSize) {
    return SizedBox(
      height: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              "لاتوجد بيانات",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: Text(
              "لاتوجد اي بيانات حاليا جرب اضافة بيانات باستخدام زر الاضافة",
              style: TextStyle(fontSize: 12, color: Colors.black38),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "لاتوجد بيانات",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        Text(
          "لاتوجد اي بيانات حاليا جرب اضافة بيانات باستخدام زر الاضافة\nاو عبر اعاده ضبط بيانات التطبيق من اعدادات الاذكار",
          style: TextStyle(fontSize: 18, color: Colors.black38),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}