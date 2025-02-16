import 'package:athkari/app/core/ModelBottomSheet/add_dhkar_modelbottomsheet.dart';
import 'package:athkari/app/core/methods/build_appbar_method.dart';
import 'package:athkari/app/core/methods/build_searchbae_method.dart';
import 'package:athkari/app/core/widgets/dekar_card_widget.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/presentation/widgets/dekhar_card_widget.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/daily_wered/presentation/pages/side_title_widget.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          buildAddDhaderWithEsnadBottomSheet(context, formKey, addCategoryText);
        },
        tooltip: 'Add Dhkar', // Tooltip for accessibility
        child: const Icon(Icons.add), // Icon for the button
      ),
      appBar: buildAppBar(context, widget.category.name ?? 'Category Details'),
      body: Column(
        children: [
          buildSearchBar(context, (query) {
            // Placeholder function for search functionality
            // Implement search logic here
          }),
          SideTitle(
            count: widget.category.dhkars?.length ?? 0,
            title: "عدد الاذكار",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.category.dhkars?.length ?? 0,
              itemBuilder: (context, index) => DekharCardWidget(
                dekhar: widget.category.dhkars![index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
