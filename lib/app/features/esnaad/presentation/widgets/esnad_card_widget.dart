import 'package:athkari/app/core/ModelBottomSheet/delete_esnad_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/update_esnad_modelbottomsheet.dart';
import 'package:athkari/app/core/methods/success_snackbar.dart';
import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/core/widgets/custome_container.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class EsnadCardWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController esnadUpdatedValueController;
  final EsnadEntity esnad;
  final double fontSize;

  const EsnadCardWidget({
    super.key,
    required this.formKey,
    required this.esnad,
    this.fontSize = 18.0,
    required this.esnadUpdatedValueController,
  });
  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Esnad text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              esnad.name!,
              textAlign: TextAlign.center,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: fontSize),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    child: PopupMenuButton(
                      menuPadding: EdgeInsets.zero,
                      color: Colors.white,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.blueGrey,
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          _buildPopupMenuUpdateMethod(context),
                          _buildPopupMenuDeleteMethod(context),
                        ];
                      },
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      Share.share('Check out my website https://example.com');
                    },
                    child: Icon(
                      Icons.share,
                      color: Colors.blueGrey,
                    ),
                  ),
                  InkWell(
                    radius: 300,
                    borderRadius: BorderRadius.circular(150),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: esnad.name!));
                      successToastMessage(context, "تم نسخ النص");
                    },
                    child: Icon(
                      Icons.copy,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),

              // Related Dekres
              Text(
                "عدد الاذكار المرتيطة ${esnad.dekarsList!.length} ذكر",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: fontSize, color: Colors.black12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<dynamic> _buildPopupMenuDeleteMethod(BuildContext context) {
    return PopupMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              buildShowDeleteBottomSheet(
                context,
                () {
                  context.read<EsnadsCubit>().deleteEsnad(esnad.id!);
                },
              );
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

  PopupMenuItem<dynamic> _buildPopupMenuUpdateMethod(BuildContext context) {
    return PopupMenuItem(
      child: InkWell(
        onTap: () {
          buildUpdateEsnadModalBottomSheet(
              context, formKey, esnadUpdatedValueController, esnad.id!);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "تعديل النص",
              style: TextStyle(
                color: Color.fromARGB(255, 90, 202, 165),
              ),
            ),
            Icon(
              Icons.update,
              color: Color.fromARGB(255, 90, 202, 165),
            ),
          ],
        ),
      ),
    );
  }
}
