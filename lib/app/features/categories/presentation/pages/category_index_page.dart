import 'package:athkari/app/core/ModelBottomSheet/add_category_modelbottomsheet.dart';
import 'package:athkari/app/core/methods/build_searchbae_method.dart';
import 'package:athkari/app/core/methods/build_waiting_state.dart';
import 'package:athkari/app/core/methods/success_snackbar.dart';
import 'package:athkari/app/core/widgets/custom_floating_action_button.dart';
import 'package:athkari/app/core/widgets/empty_state_widget.dart';
import 'package:athkari/app/core/widgets/error_state_widget.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/features/categories/presentation/widgets/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:athkari/app/core/methods/build_appbar_method.dart";

class CategoryIndexPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController addCategoryText = TextEditingController();
  final TextEditingController updateCategoryText = TextEditingController();

  CategoryIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget searchMethod = buildSearchBar(context, (query) {
      if (query.isNotEmpty) {
        context.read<CategoryCubit>().Search(query);
      } else {
        context.read<CategoryCubit>().FetchData();
      }
    });

    return Scaffold(
        appBar: buildAppBar(context, "تصنيفات الأذكار"),
        floatingActionButton: buildFloatingActionMethod(context),
        body: Column(children: [
          searchMethod,
          BlocListener<CategoryCubit, CatogeryState>(
            listener: (context, state) {
              if (state is NotifeyCategoryState) {
                successToastMessage(context, state.message);
              }
            },
            child: BlocBuilder<CategoryCubit, CatogeryState>(
                builder: (context, state) {
              if (state is LoadingCategoryState) {
                return buildWaitingState();
              } else if (state is DoneCategoryState) {
                return _buildDoneState(state);
              } else if (state is ErrorCategoryState) {
                return ErrorStateWidget(state: state);
              } else if (state is EmptyCategoryState) {
                return NoResultWidget(state.message);
              }
              return Center(child: Text("Nothing ..."));
            }),
          )
        ]));
  }

  FloatingActionButton buildFloatingActionMethod(BuildContext context) {
    return FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 128, 188, 189),
        child: Center(
          child: Icon(
            Icons.add,
          ),
        ),
        onPressed: () {
          buildAddCategoryModalBottomSheet(context, formKey, addCategoryText);
        });
  }

  Expanded _buildDoneState(DoneCategoryState state) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns
            crossAxisSpacing: 10, // Space between columns
            mainAxisSpacing: 1, // Space between rows
            childAspectRatio: 1.4, // Adjust this value to fit your design
          ),
          itemCount: state.catogories.length,
          itemBuilder: (context, index) {
            final category = state.catogories[index];

            return CategoryWidget(
              category: category,
              formKey: formKey,
              //  categoryName: categoryNameController,
            );
          },
        ),
      ),
    );
  }
}
