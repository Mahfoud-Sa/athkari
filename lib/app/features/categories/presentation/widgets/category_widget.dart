import 'package:athkari/app/core/ModelBottomSheet/add_category_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/delete_category_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/update_category_modelbottomsheet.dart';
import 'package:athkari/app/core/widgets/custome_container.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/presentation/pages/category_detailes_page.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.category,
    required this.formKey,
    required this.categoryName,
  });

  final double _fontsize = 18;
  final CategoryEntity category;
  final GlobalKey<FormState> formKey;
  final TextEditingController categoryName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CatogroesDetailesPage(
              category: category,
            ),
          ),
        );
      },
      child: CustomeContainer(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: PopupMenuButton(
                color: Colors.white, // Set the background color to white
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.blueGrey,
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    _popUpEditButton(context, category.name!),
                    _popupDeleteButton(context),
                  ];
                },
              ),
            ),
            // Center the first Text widget
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    '${category.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: _fontsize,
                        color: Color.fromARGB(255, 128, 188, 189)),
                  ),
                  const SizedBox(
                      height: 10), // Add some spacing between the texts
                  Text(
                    textAlign: TextAlign.center,
                    "عدد الاذكار ${'${category.dhkars!.length}'} ذكر",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: _fontsize - 2, color: Colors.black12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<dynamic> _popupDeleteButton(BuildContext context) {
    return PopupMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              buildShowDeleteDekeerBottomSheet(context, category.id!);
            },
            child: Text(
              "حذف",
              style: TextStyle(
                color: Color.fromARGB(255, 90, 202, 165),
              ),
            ),
          ),
          Icon(
            Icons.delete,
            color: Color.fromARGB(255, 90, 202, 165),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<dynamic> _popUpEditButton(
      BuildContext context, String updatedValue) {
    return PopupMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              final UpdatecategoryNameController =
                  TextEditingController(text: updatedValue);

              buildShowUpdateCategoryModalBottomSheet(
                  context, formKey, UpdatecategoryNameController, category.id!);
            },
            child: Text(
              "تعديل",
              style: TextStyle(
                color: Color.fromARGB(255, 90, 202, 165),
              ),
            ),
          ),
          Icon(
            Icons.add,
            color: Color.fromARGB(255, 90, 202, 165),
          ),
        ],
      ),
    );
  }
}
