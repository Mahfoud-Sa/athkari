import 'package:athkari/app/core/ModelBottomSheet/add_category_modelbottomsheet.dart';
import 'package:athkari/app/core/methods/build_searchbae_method.dart';
import 'package:athkari/app/core/methods/build_waiting_state.dart';
import 'package:athkari/app/core/methods/success_snackbar.dart';
import 'package:athkari/app/core/widgets/custom_floating_action_button.dart';
import 'package:athkari/app/core/widgets/empty_data_widget.dart';
import 'package:athkari/app/core/widgets/error_state_widget.dart';
import 'package:athkari/app/core/widgets/no_result_widget.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/features/categories/presentation/widgets/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:athkari/app/core/methods/build_appbar_method.dart";
class CategoryIndexPage extends StatefulWidget {
  const CategoryIndexPage({super.key});

  @override
  State<CategoryIndexPage> createState() => _CategoryIndexPageState();
}

class _CategoryIndexPageState extends State<CategoryIndexPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController addCategoryText;
  late final TextEditingController updateCategoryText;

  @override
  void initState() {
    super.initState();
    addCategoryText = TextEditingController();
    updateCategoryText = TextEditingController();
  }

  @override
  void dispose() {
    addCategoryText.dispose();  
    updateCategoryText.dispose();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget searchMethod = buildSearchBar(context, (query) {
      if (query.isNotEmpty) {
        context.read<CategoryCubit>().search(query);
      } else {
        context.read<CategoryCubit>().fetchData();
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
              return ErrorStateWidget(message: state.message);
            } else if (state is EmptyCategoryState) {
              return noResultWidget();
            }
            return Center(child: Text("... لا يوجد"));
          }),
        )
      ]),
    );
  }

  FloatingActionButton buildFloatingActionMethod(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 128, 188, 189),
      child: Center(
        child: Icon(Icons.add),
      ),
      onPressed: () {
        buildAddCategoryModalBottomSheet(context, formKey, addCategoryText)
          .then((_) {
            // Clear the text after modal is closed
            addCategoryText.clear();
          });
      },
    );
  }

  Expanded _buildDoneState(DoneCategoryState state) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 1,
            childAspectRatio: 1.4,
          ),
          itemCount: state.catogories.length,
          itemBuilder: (context, index) {
            final category = state.catogories[index];
            return CategoryWidget(
              category: category,
              formKey: formKey,
            );
          },
        ),
      ),
    );
  }
}