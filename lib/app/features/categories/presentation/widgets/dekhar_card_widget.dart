import 'package:athkari/app/core/ModelBottomSheet/add_to_dailywered_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/delete_category_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/delete_dhkar_bottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/edit_dekhar_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/remove_dailywered_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/update_dhkar_with_esnad_modelbottomsheet.dart';
import 'package:athkari/app/core/widgets/custome_container.dart';
import 'package:athkari/app/core/widgets/esnad_menu_button_widget.dart';
import 'package:athkari/app/features/categories/data/modules/category_models.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class DekharCardWidget extends StatefulWidget {
  const DekharCardWidget(
      {super.key, required this.dekhar, required this.formKey});
  final double _fontsize = 18;
  final DhkarEntity dekhar;
  final isAddToDailyWered = false;
  final GlobalKey<FormState> formKey;
  @override
  State<DekharCardWidget> createState() => _DekarCardWidgetState();
}

class _DekarCardWidgetState extends State<DekharCardWidget>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _heightAnimation = Tween<double>(
      begin: 0,
      end: 50, // Estimated height of esnad text
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5, // 180 degrees in radians (π ≈ 3.14, 0.5 is half rotation)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      child: Stack(
        children: [
          // Main content column
          Column(
            children: [
              // Title and repetition
              _buildTitleWithRepetation(context),

              // Animated esnad text
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    height: _heightAnimation.value,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Text(
                  widget.dekhar.esnad?.name ?? "",
                  style: TextStyle(
                      color: const Color(0xffc8c8c8),
                      fontWeight: FontWeight.w400,
                      fontFamily: "IBMPlexSansArabic",
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                  textAlign: TextAlign.right,
                ),
              ),

              // Spacer for action buttons
              const SizedBox(height: 28),
            ],
          ),

          // Action buttons positioned at bottom with tight spacing
          Positioned(
            bottom: 4,
            left: 0,
            right: 0,
            child: _buildActionToggle(context),
          ),
        ],
      ),
    );
  }

  Widget _buildActionToggle(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left actions - using Stack for precise positioning
          SizedBox(
            width: 96,
            height: 24,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // More options button
                Positioned(
                    left: 0,
                    // context,widget.formKey,widget.dekhar,updateRepetationController
                    child: MenuButtonWidget<DhkarEntity>(
                        formKey: widget.formKey,
                        entity: widget.dekhar,
                        context: context,
                        updateMethod: buildUpdateDhaderWithEsnadBottomSheet,
                        deleteMethod: (context, entity) {
                          return buildShowDeleteCategoryBottomSheet(
                              context, widget.dekhar.id!);
                        }) //_buildPopupMenuButton(),
                    ),

                // Share button
                Positioned(
                  left: 24,
                  child: _buildIconButton(Icons.share, shareMethod),
                ),

                // Copy button
                Positioned(
                  left: 48,
                  child: _buildIconButton(Icons.copy, () {
                    Clipboard.setData(ClipboardData(
                        text:
                            '${widget.dekhar.dhkar}\n\n${widget.dekhar.esnad?.name ?? ""}'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم نسخ النص')),
                    );
                  }),
                ),

                // Add button
                Positioned(
                  left: 72,
                  child: _buildIconButton(
                      1 > 3 ? Icons.add : Icons.delete,
                      3 > 4
                          ? () {
                              buildShowRemoveDekeerBottomSheet(
                                  context, widget.dekhar.id!);
                            }
                          : () {
                              buildAddtoDailyweredModalBottomSheet(
                                  context, widget.formKey, widget.dekhar.id!);
                            }),
                ),
              ],
            ),
          ),

          // Right actions - expand/collapse with animation
          InkWell(
            onTap: _toggleExpanded,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _rotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationAnimation.value *
                            3.14, // Convert to radians (π)
                        child: child,
                      );
                    },
                    child: Icon(
                      Icons.expand_more,
                      color: const Color(0xFF80BCBD),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    'عرض السند',
                    style: TextStyle(
                      fontSize: 13,
                      color: const Color(0xFF80BCBD),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void shareMethod() => Share.share(
      '${widget.dekhar.dhkar}\n\n${widget.dekhar.esnad?.name ?? ""}');

//   Widget _buildPopupMenuButton() {
//   // Define your custom text style
//   const TextStyle customTextStyle = TextStyle(
//     color: Color(0xFF80BCBD), // Using your color value
//     fontWeight: FontWeight.w400,
//     fontFamily: "IBMPlexSansArabic",
//     fontStyle: FontStyle.normal,
//     fontSize: 12.0
//   );

//   return SizedBox(
//     width: 24,
//     height: 24,
//     child: Directionality(  // Wrap with Directionality for RTL support
//       textDirection: TextDirection.rtl,
//       child: PopupMenuButton(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         elevation: 20,
//         shadowColor: const Color(0x33c8c8c8),
//         padding: EdgeInsets.zero,
//         icon: Icon(
//           Icons.more_vert,
//           color: const Color(0xFF80BCBD),
//           size: 18,
//         ),
//         itemBuilder: (context) => [
//           PopupMenuItem(
//             child: ListTile(
//               trailing: const Icon(Icons.delete, size: 20,color: Color(0xFF80BCBD),), // Changed to trailing
//               title: const Text(
//                 'حذف',
//                 style: customTextStyle,
//                 textAlign: TextAlign.right,  // Right align text
//               ),
//               onTap: () {

//                 showDeleteDhkarBottomSheet(context,widget.dekhar.id!);
//               },
//             ),
//           ),
//           PopupMenuItem(
//             child: ListTile(
//               trailing: const Icon(Icons.edit, size: 20,color: Color(0xFF80BCBD)), // Changed to trailing
//               title: const Text(
//                 'تعديل',
//                 style: customTextStyle,
//                 textAlign: TextAlign.right,  // Right align text
//               ),
//               onTap: () {
//                 TextEditingController updateRepetationController = TextEditingController(
//                   text: widget.dekhar.repetitions.toString(),
//                 );
//                 Navigator.pop(context);
//                 buildUpdateDhaderWithEsnadBottomSheet(context,widget.formKey,widget.dekhar,updateRepetationController);
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

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

  Widget _buildTitleWithRepetation(BuildContext context) {
    return InkWell(
      onTap: _toggleExpanded,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Dhkar text
            Expanded(
              child: Text(
                widget.dekhar.dhkar ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: widget._fontsize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
