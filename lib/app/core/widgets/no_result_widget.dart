import 'package:flutter/material.dart';

Column noResultWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "لاتوجد نتائج",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          Text(
            "لاتوجد نتائج لبحثك، جرب البحث باستخدام \nكلمة مفتاحية أخرى...",
            style: TextStyle(fontSize: 18, color: Colors.black38),
            textAlign: TextAlign.center,
          )
        ]);
