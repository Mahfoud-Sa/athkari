import 'package:athkari/app/core/ModelBottomSheet/delete_dhkar_bottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/edit_dekhar_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/update_esnad_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/remove_dailywered_modelbottomsheet.dart';
import 'package:athkari/app/core/widgets/custome_container.dart';
import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class DekarDailyWereCardWidget extends StatefulWidget {
  DekarDailyWereCardWidget({
    super.key,
    required this.dhkar,
  });

  final DailyWeredModel dhkar;
  final double _fontSize = 18;

  @override
  State<DekarDailyWereCardWidget> createState() =>
      _DekarDailyWereCardWidgetState();
}

class _DekarDailyWereCardWidgetState extends State<DekarDailyWereCardWidget>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController deleteDailywered = TextEditingController();
  final TextEditingController updateRepetation = TextEditingController();
  int _noOfRepeating = 0;
  
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _noOfRepeating = widget.dhkar.repetitions ?? 0;
    
    // Animation setup
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
      end: 0.5, // 180 degrees in radians
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
    return InkWell(
      onTap: () {
        setState(() {
          if (_noOfRepeating != 0) {
            _noOfRepeating -= 1;
          }
          if (_noOfRepeating == 0) {
            context.read<DailyWereCubit>().doneDekher(widget.dhkar.id!);
          }
        });
      },
      borderRadius: BorderRadius.circular(15),
      child: CustomeContainer(
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
                    widget.dhkar.esnad?.name ?? "",
                    style: TextStyle(
                      color: const Color(0xffc8c8c8),
                      fontWeight: FontWeight.w400,
                      fontFamily: "IBMPlexSansArabic",
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0
                    ),
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
            
            // Repetition count positioned in the middle bottom
            Positioned(
              bottom: 4,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 80,
                  height: 25,
                  decoration: BoxDecoration(
                    color: const Color(0xFF80BCBD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      _noOfRepeating.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                  child: _buildPopupMenuButton(),
                ),
                
                // Share button
                Positioned(
                  left: 24,
                  child: _buildIconButton(Icons.share, () {
                    Share.share('${widget.dhkar.dhkar}\n\n${widget.dhkar.esnad?.name ?? ""}');
                  }),
                ),
                
                // Copy button
                Positioned(
                  left: 48,
                  child: _buildIconButton(Icons.copy, () {
                    Clipboard.setData(ClipboardData(text:'${widget.dhkar.dhkar}\n\n${widget.dhkar.esnad?.name ?? ""}'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم نسخ النص')),
                    );
                  }),
                ),
                
                // Remove from daily wered button
                Positioned(
                  left: 72,
                  child: _buildIconButton(Icons.delete, () {
                    buildShowRemoveDekeerBottomSheet(context);
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
                        angle: _rotationAnimation.value * 3.14, // Convert to radians (π)
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

  Widget _buildPopupMenuButton() {
    // Define your custom text style
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
          itemBuilder: (context) => [
            PopupMenuItem(
              child: ListTile(
                trailing: const Icon(Icons.edit, size: 20, color: Color(0xFF80BCBD)),
                title: const Text(
                  'تعديل مرات التكرار',
                  style: customTextStyle,
                  textAlign: TextAlign.right,
                ),
                onTap: () {
                  Navigator.pop(context);
                  updateRepetation.text = _noOfRepeating.toString();
                  showEditRepetitionsBottomSheet(
                    context, formKey, updateRepetation, widget.dhkar.id!);
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                trailing: const Icon(Icons.delete, size: 20, color: Color(0xFF80BCBD)),
                title: const Text(
                  'حذف من الورد اليومي',
                  style: customTextStyle,
                  textAlign: TextAlign.right,
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDeleteDhkarBottomSheet(context, widget.dhkar.id!);
                },
              ),
            ),
          ],
        ),
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

  Widget _buildTitleWithRepetation(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_noOfRepeating != 0) {
            _noOfRepeating -= 1;
          }
          if (_noOfRepeating == 0) {
            context.read<DailyWereCubit>().doneDekher(widget.dhkar.id!);
          }
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dhkar text
            Expanded(
              child: Text(
                widget.dhkar.dhkar ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: widget._fontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}