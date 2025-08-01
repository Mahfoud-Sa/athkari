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
              CustomTextFormFieldWidget(value: categoryName),
              const SizedBox(height: 20),
              AddButtonWidget(
                buttonText: "التعدل على اسم التصنيف",
                formKey: formKey,
                esnadValue: categoryName,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.read<CategoryCubit>().updateCategory(
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
            ],
          ),
        ),
      ),
    ),
  );
}
