import 'package:athkari/app/core/methods/build_appbar_method.dart';
import 'package:athkari/app/core/methods/build_searchbae_method.dart';
import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit_state.dart';
import 'package:athkari/app/features/esnaad/presentation/widgets/esnad_card_widget.dart';
import 'package:athkari/app/features/home/presentation/pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EsnaadsPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var _esnadValue = TextEditingController();
  var _esnadUpdatedValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "الإسنادات"),
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          onPressed: () {
            buildEsnadModalBottomSheet(context);
          }),
      body: Column(
        children: [
          buildSearchBar(
            context,
            (query) {
              if (query.isNotEmpty) {
                context.read<EsnadsCubit>().search(query);
              } else {
                context.read<EsnadsCubit>().fetchData();
              }
            },
          ),
          Expanded(
              // Ensure the ListView takes the remaining space
              child: BlocListener<EsnadsCubit, EsnadState>(
            listenWhen: (previous, current) {
              return current == NotifeyEsnadState;
            },
            listener: (context, state) {
              // Show the SnackBar when the state is ShowMessageState
              if (state is NotifeyEsnadState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    duration: const Duration(seconds: 3),
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }
            },
            child: BlocBuilder<EsnadsCubit, EsnadState>(
              builder: (context, state) {
                if (state is LoadingEsnadState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DoneEsnadState) {
                  return ListView.builder(
                    itemCount: state.esnads.length,
                    itemBuilder: (context, index) {
                      final item = state.esnads[index];
                      return EsnadCardWidget(
                        esnad: item,
                        noOfRelatedDekres: 5,
                        formKey: formKey,
                        esnadValueController:
                            TextEditingController(text: item.name),
                      );
                    },
                  );
                } else if (state is EmptyEsnadState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Trigger a specific event
                        context.read<EsnadsCubit>().fetchData();
                      },
                      child: Text('إعاده المحاولة'),
                    ),
                  );
                }
              },
            ),
          )),
        ],
      ),
    );
  }

  Future<dynamic> buildEsnadModalBottomSheet(BuildContext context) {
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
                  controller: _esnadValue,
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
                buttonText: "إضافة",
                esnadValue: _esnadValue,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.read<EsnadsCubit>().addEsnad(
                          _esnadValue.text,
                        );
                  }
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
}
