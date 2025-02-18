import 'package:athkari/app/core/ModelBottomSheet/add_dhkar_modelbottomsheet.dart';
import 'package:athkari/app/core/methods/build_appbar_method.dart';
import 'package:athkari/app/core/methods/build_searchbae_method.dart';
import 'package:athkari/app/core/methods/build_waiting_state.dart';
import 'package:athkari/app/core/methods/success_snackbar.dart';
import 'package:athkari/app/core/widgets/dekar_card_widget.dart';
import 'package:athkari/app/core/widgets/error_state_widget.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/features/categories/presentation/widgets/dekhar_card_widget.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/daily_wered/presentation/pages/side_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatogroesDetailesPage extends StatefulWidget {
  const CatogroesDetailesPage({super.key, required this.category});
  final CategoryEntity category;

  @override
  State<CatogroesDetailesPage> createState() => _CatogroesDetailesPageState();
}

class _CatogroesDetailesPageState extends State<CatogroesDetailesPage> {
  final formKey = GlobalKey<FormState>();
  final addCategoryText = TextEditingController();
  final editCategoryText = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCategoryDetails(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          buildAddDhaderWithEsnadBottomSheet(context, formKey, addCategoryText);
        },
        tooltip: 'Add Dhkar', // Tooltip for accessibility
        child: const Icon(Icons.add), // Icon for the button
      ),
      appBar: buildAppBar(context, widget.category.name ?? 'Category Details',
          popMethod: () {
        Navigator.pop(context);
        context.read<CategoryCubit>().FetchData();
      }),
      body: Column(
        children: [
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
              } else if (state is DoneCategoryDetailsState) {
                return _buildDoneState(state);
              } else if (state is ErrorCategoryState) {
                return ErrorStateWidget(state: state);
              } else if (state is EmptyCategoryState) {
                return buildEmptyState(state.message);
              }
              return buildEmptyState("Nothing ...");
            }),
          )
          // buildSearchBar(context, (query) {
          //   // Placeholder function for search functionality
          //   // Implement search logic here
          // }),
        ],
      ),
    );
  }

  Center buildEmptyState(String message) => Center(child: Text(message));

  Column _buildDoneState(DoneCategoryDetailsState state) {
    return Column(
      children: [
        // SideTitle(
        //   count: state.catogory.dhkars!.length ?? 0,
        //   title: "عدد الاذكار",
        // ),
        Expanded(
          child: ListView.builder(
              itemCount: widget.category.dhkars?.length ?? 0,
              itemBuilder: (context, index) => Text("data") //DekharCardWidget(
              //   dekhar: state.catogory.dhkars![index],
              // ),
              ),
        ),
      ],
    );
  }
}
