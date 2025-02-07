import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> buildAddDhaderBottomSheet(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController textEditingController_1,
    TextEditingController textEditingController_2) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => Form(
      key: formKey,
      onChanged: () {},
      child: SingleChildScrollView(
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
                'اضافة ذكر',
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
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    'نص الذكر (المتن)',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
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
                controller: textEditingController_2,
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
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: const Text(
                    'السند',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Color.fromARGB(255, 128, 188, 189)),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    child: Text("data"),
                    value: "",
                  ),
                  DropdownMenuItem(child: Text("data")),
                  DropdownMenuItem(child: Text("data")),
                  DropdownMenuItem(child: Text("data")),
                  DropdownMenuItem(child: Text("data")),
                  DropdownMenuItem(child: Text("data")),
                  DropdownMenuItem(child: Text("data")),
                ],
                onChanged: (value) {},
                value: "",
                icon: IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                // hint: Text("اختر من قائمة الاسنادات"),
                // borderRadius: BorderRadius.circular(15),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none, // Remove the visible border
                  ),
                  hintText: "اختر من قائمة الاسنادات",
                  filled: true, // Enable background color
                  // fillColor: Color.fromARGB(
                  //     255, 214, 214, 213), // Set the background color
                  contentPadding: const EdgeInsets.symmetric(
                      // vertical: 100,
                      horizontal: 20), // Increased vertical padding
                ),
                // child: DropdoenButton<String>(
                //   controller: textEditingController_1,
                //   keyboardType: TextInputType.text,
                //   textAlign: TextAlign.right,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(25),
                //       borderSide: BorderSide.none, // Remove the visible border
                //     ),

                //     hintText: 'ادخل النص',
                //     filled: true, // Enable background color
                //     fillColor: Colors.black12, // Set the background color
                //     contentPadding: const EdgeInsets.symmetric(
                //         vertical: 10, horizontal: 20), // Adjust padding
                //   ),
              ),
            ),
            BlocProvider(
              create: (context) => getIt<DailyWereCubit>(),
              child: InkWell(
                onTap: () {
                  //  formKey.currentState.validate();
                  if (formKey.currentState!.validate()) {
                    context.read<DailyWereCubit>().AddDheker(
                        textEditingController_2.text,
                        textEditingController_1.text);
                  }
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 300,
                  height: 50,
                  child: Center(
                    child: Text(
                      'أضافة ذكر',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 128, 188, 189),
                      borderRadius: BorderRadius.circular(30)),
                ),
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
    ),
  );
}
