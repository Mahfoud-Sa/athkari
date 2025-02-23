import 'package:athkari/app/core/widgets/AddtextFormFeildWidget.dart';
import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> buildShowUpdateCategoryModalBottomSheet(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController categoryName,
  int categoryId,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 15,
          left: 15),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
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
                  'التعديل على اسم التصنيف',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      'اسم التصنيف',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  // maxLines: 5,
                  controller: categoryName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لايمكن اضافة سند فارغ, جرب كتابة نص الإسناد';
                    }
                    if (value.length >= 150) {
                      return 'لا يجب ان يحتوي نص الاصناد على اكثر من 150حرف';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    hintText: '...ادخل النص هنا',
                    filled: true,
                    fillColor: Color.fromARGB(255, 214, 214, 213),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
              // AddTextFormFeildWidget(value: categoryName),
              const SizedBox(height: 20),
              AddButtonWidget(
                buttonText: "التعدل على اسم التصنيف",
                formKey: formKey,
                esnadValue: categoryName,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.read<CategoryCubit>().UpdateCategory(
                          categoryId,
                          categoryName.text,
                        );
                    Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(height: 10),
              CancelButtonWidget(),
              const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     controller: categoryName,
              //     keyboardType: TextInputType.text,
              //     textAlign: TextAlign.right,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(25),
              //         borderSide: BorderSide.none, // Remove the visible border
              //       ),

              //       hintText: 'اسم التصنيف',
              //       filled: true, // Enable background color
              //       fillColor: Colors.black12, // Set the background color
              //       contentPadding: const EdgeInsets.symmetric(
              //           vertical: 10, horizontal: 20), // Adjust padding
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     if (formKey.currentState!.validate()) {
              //       context.read<CategoryCubit>().UpdateCategory(
              //             categoryId,
              //             categoryName.text,
              //           );
              //       Navigator.pop(context);
              //     }
              //   },
              //   borderRadius: BorderRadius.circular(20),
              //   child: Container(
              //     width: 300,
              //     height: 50,
              //     child: Center(
              //       child: Text(
              //         'حفظ',
              //         style: TextStyle(
              //             color: Colors.white, fontWeight: FontWeight.w600),
              //       ),
              //     ),
              //     decoration: BoxDecoration(
              //         color: Color.fromARGB(255, 128, 188, 189),
              //         borderRadius: BorderRadius.circular(30)),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ),
  );
}
