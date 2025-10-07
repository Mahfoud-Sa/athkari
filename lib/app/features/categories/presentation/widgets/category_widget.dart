import 'package:athkari/app/core/ModelBottomSheet/delete_category_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/update_category_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/update_esnad_modelbottomsheet.dart';
import 'package:athkari/app/core/widgets/custome_container.dart';
import 'package:athkari/app/core/widgets/esnad_menu_button_widget.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/presentation/pages/category_detailes_page.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.category,
    required this.formKey,
    //  required this.categoryName,
  });

  final double _fontsize = 16;
  final CategoryEntity category;
  final GlobalKey<FormState> formKey;
  // final TextEditingController categoryName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CatogoryDetailesPage(
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
              left: 0, // small offset from the left
              top: 0, // small offset from the top
              child: SizedBox(
                width: 32, // smaller width
                height: 32, // smaller height
                child: MenuButtonWidget(
                  formKey: formKey,
                  entity: category,
                  context: context,
                  updateMethod: buildShowUpdateCategoryModalBottomSheet,
                  deleteMethod: buildShowDeleteCategoryBottomSheet,
                ),
              ),
            ),
            // Center the first Text widget
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    '${category.name}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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
}
