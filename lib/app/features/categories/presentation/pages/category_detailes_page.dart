import 'package:athkari/app/core/ModelBottomSheet/add_dhkar_with_esnad_modelbottomsheet.dart';
import 'package:athkari/app/core/methods/build_appbar_method.dart';
import 'package:athkari/app/core/methods/build_waiting_state.dart';
import 'package:athkari/app/core/methods/error_snakbar.dart';
import 'package:athkari/app/core/methods/success_snackbar.dart';
import 'package:athkari/app/core/widgets/empty_data_widget.dart';
import 'package:athkari/app/core/widgets/error_state_widget.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_details_cubit.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_details_cubit_states.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CategoryDetailsCubit>()
          .fetchCategoryDetails(widget.category.id!);
    });
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
          //  context.read<CategoryCubit>().fetchData();
        },
      ),
      body: BlocListener<CategoryDetailsCubit, CategoryDetailsState>(
        listener: (context, state) {
          if (state is NotifyCategoryDetailsState) {
            successToastMessage(context, state.message);
          } else if (state is DeleteErrorCategoryDetailsState) {
            errorToastMessage(context, state.message);
          }
        },
        child: BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
          builder: (context, state) {
            if (state is LoadingCategoryDetailsState) {
              return buildWaitingState();
            } else if (state is DoneCategoryDetailsState) {
              print(state.categoryDetails.dhkars!.first.inDailyWered);
              return _buildDoneState(state);
            } else if (state is ErrorCategoryDetailsState) {
              return ErrorStateWidget(message: state.message);
            } else if (state is EmptyCategoryDetailsState) {
              return emptyDataWidget();
            }
            return emptyDataWidget();
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

  //Center buildEmptyState(String message) => Center(child: Text(message));

  Widget _buildDoneState(DoneCategoryDetailsState state) {
    return Column(
      children: [
        SideTitle(
          count: state.categoryDetails.dhkars?.length ?? 0,
          title: "عدد الاذكار",
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.categoryDetails.dhkars?.length ?? 0,
            itemBuilder: (context, index) {
              final dekhar = state.categoryDetails.dhkars![index];
              return DekharCardWidget(
                dekhar: dekhar,
                formKey: formKey,
              );
            },
          ),
        ),
      ],
    );
  }
}
