import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> buildAddEsnadModalBottomSheet(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController esnadValue,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25),
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
                'إضافة إسناد جديد',
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
                    'نص الإسناد',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Color.fromARGB(255, 128, 188, 189)),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 5, // Allows the field to expand as the user types
                controller: esnadValue,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لايمكن اضافة سند فارغ, جرب كتابة نص الإسناد';
                  }
                  if (value.length == 150) {
                    return 'لا يجب ان يحتوي نص الاصناد على اكثر من 150حرف';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none, // Remove the visible border
                  ),
                  hintText: '...ادخل النص هنا',
                  filled: true, // Enable background color
                  fillColor: Color.fromARGB(
                      255, 214, 214, 213), // Set the background color
                  contentPadding: const EdgeInsets.symmetric(
                      // vertical: 100,
                      horizontal: 20), // Increased vertical padding
                ),
              ),
            ),
            AddButtonWidget(
              buttonText: "إضافة إسناد",
              esnadValue: esnadValue,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  context.read<EsnadsCubit>().addEsnad(
                        esnadValue.text,
                      );
                }
                Navigator.pop(context);
              },
              formKey: formKey,
            ),
            const SizedBox(
              height: 10,
            ),
            CancelButtonWidget(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ),
  );
}
