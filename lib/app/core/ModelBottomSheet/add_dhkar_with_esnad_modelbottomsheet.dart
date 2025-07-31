import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> buildAddDhaderWithEsnadBottomSheet(
  BuildContext context,
  GlobalKey<FormState> formKey,
  final CategoryEntity category,
  TextEditingController textEditingController_1,
) {
  int? esnadId;
  final ValueNotifier<bool> esnadValid = ValueNotifier<bool>(false);

  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 15,
            right: 15,
          ),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    height: 3,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 12),
                  child: Center(
                    child: Text(
                      'إضافة ذكر',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                // Text Field Section
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'نص الذكر (المتن)',
                    
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                      
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: textEditingController_1,
                    maxLines: 5,
                    minLines: 1,
                    textDirection: TextDirection.rtl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال نص الذكر';
                      }
                      if (value.length > 150) {
                        return 'يجب ألا يتجاوز النص 150 حرفاً';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      hintText: '...أدخل النص هنا',
                      hintTextDirection: TextDirection.rtl,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 214, 214, 213),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
                
                // Esnad Dropdown Section
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'اختر السند',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<CategoryCubit, CatogeryState>(
                    builder: (context, state) {
                      if (state is LoadingCategoryState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is DoneEsnadsState) {
                        return ValueListenableBuilder<bool>(
                          valueListenable: esnadValid,
                          builder: (context, isValid, child) {
                            return DropdownButtonFormField<int>(
                              validator: (value) {
                                if (value == null) {
                                  esnadValid.value = false;
                                  return 'الرجاء اختيار سند';
                                }
                                esnadValid.value = true;
                                return null;
                              },
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              items: state.EsandsList.map((EsnadEntity? esnad) {
                                return DropdownMenuItem<int>(
                                  value: esnad?.id,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      esnad?.name ?? '',
                                      textDirection: TextDirection.rtl,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1, // Changed to 1 line to prevent overflow
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                esnadId = value;
                                formKey.currentState?.validate();
                              },
                              value: esnadId,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "اختر من القائمة",
                                hintTextDirection: TextDirection.rtl,
                                filled: true,
                                fillColor: const Color.fromARGB(255, 214, 214, 213),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox(height: 35, width: 120);
                    },
                  ),
                ),
                
                // Buttons Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AddButtonWidget(
                        formKey: formKey,
                        esnadValue: textEditingController_1,
                        buttonText: 'إضافة الذكر',
                        onTap: () {
                          final isFormValid = formKey.currentState!.validate();
                          final isEsnadValid = esnadId != null;
                          
                          if (isFormValid && isEsnadValid) {
                            context.read<CategoryCubit>().addDekharWithEsnad(
                              category.id!,
                              esnadId!,
                              textEditingController_1.text,
                            );
                            Navigator.pop(context);
                          } else if (!isEsnadValid) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'الرجاء اختيار سند قبل الإضافة',
                                  textDirection: TextDirection.rtl,
                                ),
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      const CancelButtonWidget(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

