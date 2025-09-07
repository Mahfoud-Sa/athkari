
import 'package:athkari/app/core/ModelBottomSheet/delete_esnad_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/update_esnad_modelbottomsheet.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EsnadMenuButtonWidget extends StatelessWidget {
  const EsnadMenuButtonWidget({
    super.key,
    required this.formKey,
    required this.esnadUpdatedValueController,
    required this.esnad,
    required this.context,
     
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController esnadUpdatedValueController;
  final EsnadEntity esnad;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    const TextStyle customTextStyle = TextStyle(
      color: Color(0xFF80BCBD),
      fontWeight: FontWeight.w400,
      fontFamily: "IBMPlexSansArabic",
      fontStyle: FontStyle.normal,
      fontSize: 12.0
    );

    return SizedBox(
      width: 24,
      height: 24,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: PopupMenuButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 20,
          shadowColor: const Color(0x33c8c8c8),
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.more_vert,
            color: const Color(0xFF80BCBD),
            size: 18,
          ),
          // Let the menu size itself based on content
          itemBuilder: (context) => [
             PopupMenuItem(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: InkWell(
        onTap: () {
                Navigator.pop(context);
                buildUpdateEsnadModalBottomSheet(
                  context, formKey, esnadUpdatedValueController, esnad.id!
                );
              },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             
             
              Text(
                'تعديل النص',
                style: customTextStyle,
                textAlign: TextAlign.right,
              ), const SizedBox(width: 8),
               SvgPicture.asset(
                  "assets/svgs/edit_icon.svg",
                  width: 16, // Slightly smaller icon for better proportion
                  height: 16,
                 
                ),
            ],
          ),
        ),
      ),
    ),
            
            PopupMenuItem(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: InkWell(
        onTap: () {
                Navigator.pop(context);
                buildGeneralShowDeleteBottomSheet(
                  context,
                  () {
                    context.read<EsnadsCubit>().deleteEsnad(esnad.id!);
                  },
                  "حذف الاسناد",
                  'هل انت متاكد من حذف هذا الاسناد؟',
                );
              },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             
             
              Text(
                'حذف',
                style: customTextStyle,
                textAlign: TextAlign.right,
              ), const SizedBox(width: 8),
               SvgPicture.asset(
                  "assets/svgs/error_icon.svg",
                  width: 16, // Slightly smaller icon for better proportion
                  height: 16,
                 
                ),
            ],
          ),
        ),
      ),
    ),
           
          ],
        ),
      ),
    );
  }
}