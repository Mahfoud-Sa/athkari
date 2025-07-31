import 'package:athkari/app/core/ModelBottomSheet/add_dhkar_with_esnad_modelbottomsheet.dart';
import 'package:athkari/app/core/methods/build_appbar_method.dart';
import 'package:athkari/app/core/methods/build_waiting_state.dart';
import 'package:athkari/app/core/methods/success_snackbar.dart';
import 'package:athkari/app/core/widgets/error_state_widget.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/features/categories/presentation/widgets/dekhar_card_widget.dart';
import 'package:athkari/app/features/daily_wered/presentation/pages/side_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatogoryDetailesPage extends StatefulWidget {
  const CatogoryDetailesPage({super.key, required this.category});
  final CategoryEntity category;

  @override
  State<CatogoryDetailesPage> createState() => _CatogoryDetailesPageState();
}

class _CatogoryDetailesPageState extends State<CatogoryDetailesPage> {
  final formKey = GlobalKey<FormState>();
  final addCategoryText = TextEditingController();
  final editCategoryText = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCategoryDetails(widget.category.id!);
  }
@override
void dispose() {
  addCategoryText.dispose();
  editCategoryText.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionMethod(context),
      appBar: buildAppBar(
        context,
        widget.category.name ?? 'تفاصيل التصنيف',
        popMethod: () {
          Navigator.pop(context);
          context.read<CategoryCubit>().FetchData();
        },
      ),
      body: BlocListener<CategoryCubit, CatogeryState>(
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
          },
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionMethod(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 128, 188, 189),
      child: const Center(
        child: Icon(Icons.add),
      ),
      onPressed: () {
        context.read<CategoryCubit>().fetchEsnadsData();
        buildAddDhaderWithEsnadBottomSheet(
          context,
          formKey,
          widget.category,
          addCategoryText,
        );
      },
    );
  }

  Center buildEmptyState(String message) => Center(child: Text(message));

  Widget _buildDoneState(DoneCategoryDetailsState state) {
    return Column(
      children: [
        SideTitle(
          count: state.catogory.dhkars?.length ?? 0,
          title: "عدد الاذكار",
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.catogory.dhkars?.length ?? 0,
            itemBuilder: (context, index) {
              final dekhar = state.catogory.dhkars![index];
              return DekharCardWidget(dekhar: dekhar);
            },
          ),
        ),
      ],
    );
  }
}
