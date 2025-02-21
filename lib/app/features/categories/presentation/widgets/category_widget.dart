import 'package:athkari/app/core/ModelBottomSheet/delete_category_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/update_category_modelbottomsheet.dart';
import 'package:athkari/app/core/widgets/custome_container.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/presentation/pages/category_detailes_page.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {super.key,
      required this.category,
      required this.formKey,
      required this.categoryName});
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
            ));
      },
      borderRadius: BorderRadius.circular(15),
      child: CustomeContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PopupMenuButton(
              color: Colors.white, // Set the background color to white
              padding: EdgeInsets.all(0), // No padding
              //  onChanged: (value) {},
              icon: Expanded(
                child: Icon(
                  Icons.more_vert,
                  color: Colors.blueGrey,
                ),
              ),
              itemBuilder: (BuildContext context) {
                return [
                  _popUpEditButton(context),
                  _popupDeleteButton(context),
                ];
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  textAlign: TextAlign.center,
                  '${category.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: _fontsize),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "عدد الاذكار ${'${category.dhkars!.length}'} ذكر",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: _fontsize, color: Colors.black12),
                ),
              ],
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
        )
      ],
    ));
  }

  PopupMenuItem<dynamic> _popUpEditButton(
    BuildContext context,
    //GlobalKey<FormState> formKey,
    // TextEditingController categoryName,
    // categoryId
  ) {
    return PopupMenuItem(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            buildShowUpdateCategoryModalBottomSheet(
                context, formKey, categoryName, category.id!);
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
        )
      ],
    ));
  }
}
