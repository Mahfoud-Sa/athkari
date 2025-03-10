import 'package:flutter/material.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> buildShowDeleteDekeerBottomSheet(
    BuildContext context, int categoryId) {
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
              "حذف",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const Row(
            children: [
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: const Text(
                  'هل انت متاكد من حذف هذا الصنف؟',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Color.fromARGB(255, 128, 188, 189)),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              context.read<CategoryCubit>().DeleteCategory(
                    categoryId,
                  );
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 300,
              height: 50,
              child: Center(
                child: const Text(
                  'حذف الصنف',
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
