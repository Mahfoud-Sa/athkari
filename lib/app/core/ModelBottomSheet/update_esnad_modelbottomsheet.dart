import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> buildUpdateEsnadModalBottomSheet(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController esnadName,
  int esnadId,
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
          padding: EdgeInsets.symmetric(horizontal: 25),
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
                  "التعديل على الاسناد",
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
                      'نص الإسناد',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Color.fromARGB(255, 128, 188, 189)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  controller: esnadName,
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
              AddButtonWidget(
                buttonText: "حفظ",
                esnadValue: esnadName,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context
                        .read<EsnadsCubit>()
                        .updateEsnad(esnadId!, esnadName.text);
                  }
                  Navigator.pop(context);
                },
                formKey: formKey,
              ),
              SizedBox(height: 10),
              CancelButtonWidget(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    ),
  );
}
