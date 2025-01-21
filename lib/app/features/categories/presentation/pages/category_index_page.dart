import 'package:athkari/app/core/methods/build_searchbae_method.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/features/categories/presentation/pages/category_detailes_page.dart';
import 'package:athkari/app/features/categories/presentation/widgets/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:athkari/app/core/methods/build_appbar_method.dart";

class CategoryIndexPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var textEditingController_1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, "تصنيفات الأذكار"),
        floatingActionButton: FloatingActionButton.small(
            child: Icon(Icons.add),
            onPressed: () {
              buildACategoryModalBottomSheet(context);
            }),
        body: Column(children: [
          buildSearchBar(context, (query) {
            if (!query.isEmpty) {
              context.read<CategoryCubit>().Search(query);
            } else {
              context.read<CategoryCubit>().FetchData();
            }
          }),
          BlocListener<CategoryCubit, CatogeryState>(
            listener: (context, state) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text('تمت الاضافة')),
              // );
              //  Navigator.pop(context);
            },
            child: BlocBuilder<CategoryCubit, CatogeryState>(
                builder: (context, state) {
              if (state is LoadingCategoryState) {
                return WaitingStateWidget();
              } else if (state is DoneCategoryState) {
                return DoneStateWidget(state: state);
              } else if (state is ErrorCategoryState)
                return ErrorStateWidget(state: state);
              else if (state is EmptyCategoryState) {
                return const Center(
                    child: Text('جرب البحث باستخدام كلمات أخرئ'));
              } else {
                return Center(child: Text('Nothing...'));
              }
            }),
          )
        ]));
  }

  Center WaitingStateWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<dynamic> buildACategoryModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Form(
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
                  'أضافة تصنيف جديد',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w900),
                ),
              ),
              const Row(
                children: [
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: const Text(
                      'اسم التصنيف',
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
                  controller: textEditingController_1,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none, // Remove the visible border
                    ),

                    hintText: 'اسم الفئة',
                    filled: true, // Enable background color
                    fillColor: Colors.black12, // Set the background color
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20), // Adjust padding
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.read<CategoryCubit>().AddCategory(
                          textEditingController_1.text,
                        );
                  }
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 300,
                  height: 50,
                  child: Center(
                    child: const Text(
                      'اضافة',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 128, 188, 189),
                      borderRadius: BorderRadius.circular(30)),
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
}

class ErrorStateWidget extends StatelessWidget {
  final ErrorCategoryState state;
  const ErrorStateWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Trigger a specific event
          context.read<CategoryCubit>().FetchData();
        },
        child: Text(state.message.toString()),
      ),
    );
  }
}

class DoneStateWidget extends StatelessWidget {
  final DoneCategoryState state;
  const DoneStateWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 5, // Space between columns
          mainAxisSpacing: 5, // Space between rows
          childAspectRatio: 1.5, // Aspect ratio of each grid item
        ),
        itemCount: state.catogories.length,
        itemBuilder: (context, index) {
          final azkar = state.catogories[index];
          return CategoryWidget(
            title: azkar.name!,
            no_of_dekres: 5,
          );
        },
      ),
    );
  }
}
