import 'package:flutter/material.dart';

Column emptyDataWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "لاتوجد بيانات",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          Text(
            " لاتوجد اي بيانات حاليا جرب اضافة بيانات باستخدام زر الاضافة\n  او عبر اعاده ضبط بيانات التطبيق من اعدادات الاذكار",
            style: TextStyle(fontSize: 18, color: Colors.black38),
            textAlign: TextAlign.center,
          )
        ]);
