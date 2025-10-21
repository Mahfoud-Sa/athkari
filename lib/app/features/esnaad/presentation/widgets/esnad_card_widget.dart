import 'package:athkari/app/core/ModelBottomSheet/delete_category_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/delete_esand_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/delete_general_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/update_esnad_modelbottomsheet.dart';
import 'package:athkari/app/core/methods/success_snackbar.dart';
import 'package:athkari/app/core/widgets/custome_container.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:athkari/app/core/widgets/esnad_menu_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
      child: Stack(
        children: [
          // Main content column
          Column(
            children: [
              // Esnad text
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
              ),

              // Spacer for action buttons
              const SizedBox(height: 28),
            ],
          ),

          // Related Dekres text positioned at bottom right
          Positioned(
            bottom: 8,
            right: 8,
            child: Text(
              "عدد الاذكار المرتبطة ${esnad.dekarsList!.length} ذكر",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 12, color: Colors.black12),
            ),
          ),

          // Action buttons positioned at bottom left with tight spacing
          Positioned(
            bottom: 4,
            left: 0,
            child: _buildActionButtons(context),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Using Stack for precise positioning of action buttons
          SizedBox(
            width: 96,
            height: 24,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // More options button
                Positioned(
                  left: 0,
                  child: MenuButtonWidget<EsnadEntity>(
                    formKey: formKey,
                    entity: esnad,
                    context: context,
                    updateMethod: (ctx, key, controller, entity) =>
                        buildUpdateEsnadModalBottomSheet(
                            ctx, key, controller, entity.id!),
                    deleteMethod: (ctx, entity) =>
                        buildEsnadShowDeleteBottomSheet(ctx, entity.id!),
                  ),
                ),

                // Share button
                Positioned(
                  left: 24,
                  child: _buildIconButton(Icons.share, () {
                    Share.share(esnad.name!);
                  }),
                ),

                // Copy button
                Positioned(
                  left: 48,
                  child: _buildIconButton(Icons.copy, () {
                    Clipboard.setData(ClipboardData(text: esnad.name!));
                    successToastMessage(context, "تم نسخ النص");
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        splashRadius: 16,
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 16,
          color: const Color(0xFF80BCBD),
        ),
      ),
    );
  }
}
