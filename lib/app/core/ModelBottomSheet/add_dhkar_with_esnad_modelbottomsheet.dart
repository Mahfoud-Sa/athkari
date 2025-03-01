import 'package:athkari/app/core/methods/build_waiting_state.dart';
import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> buildAddDhaderWithEsnadBottomSheet(
  BuildContext context,
  GlobalKey<FormState> formKey,
  final CategoryEntity category,
  TextEditingController textEditingController_1,
) {
  int esnadId = 0;
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => Form(
      key: formKey,
      onChanged: () {},
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Ensure the Column takes minimal space
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
                  'اضافة ذكر',
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
                        'نص الذكر (المتن)',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: textEditingController_1,
                  maxLines: 5, // Allows the field to expand as the user types
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لايمكن اضافة سند فارغ, جرب كتابة نص الإسناد';
                    }
                    if (value.length == 150) {
                      return 'لا يجب ان يحتوي نص الاصناد على اكثر من 150 حرف';
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
                    fillColor:
                        Color.fromARGB(255, 214, 214, 213), // Background color
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20), // Horizontal padding
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      'السند',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<CategoryCubit, CatogeryState>(
                  builder: (context, state) {
                    if (state is LoadingCategoryState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is DoneEsnadsState) {
                      return DropdownButtonFormField<int>(
                        itemHeight: 120,
                        isExpanded:
                            true, // Ensure the dropdown takes full width
                        items: state.EsandsList.map((EsnadEntity? esnad) {
                          // Ensure esnad is not null

                          return DropdownMenuItem<int>(
                            value: esnad!.id!,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical:
                                      8), // Add padding for better spacing
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Align text to the start
                                children: [
                                  Text(
                                    esnad.name.toString(),
                                    overflow: TextOverflow
                                        .ellipsis, // Handle long text
                                    style: const TextStyle(
                                        fontSize: 16), // Customize text style
                                  ),
                                  const Divider(
                                      height: 1, thickness: 1), // Add a divider
                                ],
                              ),
                            ),
                          );
                        })
                            .where((item) => item != null)
                            .toList(), // Filter out null items
                        onChanged: (value) {
                          // Handle the selected value
                          if (value != null) {
                            esnadId = value;
                          }
                        },
                        value: state.EsandsList.isNotEmpty
                            ? state.EsandsList[0].id
                            : null, // Handle empty list
                        icon: const Icon(Icons.keyboard_arrow_down,
                            size: 24), // Customize dropdown icon
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none, // Remove border
                          ),
                          hintText: "اختر من قائمة الاسنادات", // Hint text
                          filled: true, // Enable background color
                          //   fillColor: Colors.grey[200], // Set background color
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16), // Add padding
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                BorderSide.none, // Remove border when enabled
                          ),
                        ),
                      );
                    }
                    return SizedBox(height: 35, width: 120, child: InkWell());
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AddButtonWidget(
                formKey: formKey,
                esnadValue: textEditingController_1,
                buttonText: 'أضافة ذكر',
                onTap: () {
                  formKey.currentState!.validate();
                  if (formKey.currentState!.validate()) {
                    context.read<CategoryCubit>().addDekharWithEsnad(
                          category.id!,
                          esnadId,
                          textEditingController_1.text,
                        );
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
