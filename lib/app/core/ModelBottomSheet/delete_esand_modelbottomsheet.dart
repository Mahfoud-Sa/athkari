import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> buildEsnadShowDeleteBottomSheet(
  BuildContext context,
  int esnadId,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 3,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 12),
              child: Text(
                "حذف الاسناد",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    "هل أنت متأكد من حذف هذا الاسناد؟",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color.fromARGB(255, 128, 188, 189)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                context.read<EsnadsCubit>().deleteEsnad(
                      esnadId,
                    );
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
                child: Center(
                  child: Text(
                    'موافق', // Use the provided button text
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            CancelButtonWidget(),
            SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
