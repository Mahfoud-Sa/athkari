// Bottom Sheet for Deleting Dhkar
import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_details_cubit.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showDeleteDhkarBottomSheet(BuildContext context, int id) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'حذف من الورد',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    'هل انت متأكد من حذف هذا الذكر؟',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Color.fromARGB(255, 128, 188, 189),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                // Implement delete functionality
                context.read<CategoryDetailsCubit>().deleteDekhar(id);
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 128, 188, 189),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'حذف الذكر',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 128, 188, 189),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'الغاء',
                    style: TextStyle(
                      color: Color.fromARGB(255, 128, 188, 189),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ),
  );
}
