import 'package:athkari/app/core/widgets/AddtextFormFeildWidget.dart';
import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> buildAddCategoryModalBottomSheet(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController textEditingController_1) {
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
                padding: EdgeInsets.only(top: 8, bottom: 12),
                child: Text(
                  'أضافة تصنيف جديد',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      'اسم التصنيف',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
              AddTextFormFeildWidget(value: textEditingController_1),
              const SizedBox(height: 20),
              AddButtonWidget(
                buttonText: "إضافة التصنيف",
                formKey: formKey,
                esnadValue: textEditingController_1,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.read<CategoryCubit>().AddCategory(
                          textEditingController_1.text,
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
