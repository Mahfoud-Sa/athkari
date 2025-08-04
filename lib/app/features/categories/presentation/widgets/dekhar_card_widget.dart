import 'package:athkari/app/core/widgets/custome_container.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DekharCardWidget extends StatefulWidget {
  const DekharCardWidget({super.key, required this.dekhar});
  final double _fontsize = 18;
  final DhkarEntity dekhar;

  @override
  State<DekharCardWidget> createState() => _DekarCardWidgetState();
}

class _DekarCardWidgetState extends State<DekharCardWidget> with SingleTickerProviderStateMixin {
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
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: widget._fontsize - 2,
                        color: Colors.black54,
                      ),
                  textAlign: TextAlign.center,
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
                  child: _buildPopupMenuButton(),
                ),
                
                // Share button
                Positioned(
                  left: 24,
                  child: _buildIconButton(Icons.share, 
                    () => Share.share('${widget.dekhar.dhkar}\n\n${widget.dekhar.esnad?.name ?? ""}')
                  ),
                ),
                
                // Copy button
                Positioned(
                  left: 48,
                  child: _buildIconButton(Icons.copy, () {}),
                ),
                
                // Add button
                Positioned(
                  left: 72,
                  child: _buildIconButton(Icons.add, () {}),
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
    return SizedBox(
      width: 24,
      height: 24,
      child: PopupMenuButton(
        color: Colors.white,
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.more_vert,
          color: const Color(0xFF80BCBD),
          size: 18,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.delete, size: 20),
              title: const Text('حذف من الورد اليومي'),
              onTap: () {
                Navigator.pop(context);
                buildShowDeleteDekeerBottomSheet(context);
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.edit, size: 20),
              title: const Text('تعديل الذكر'),
              onTap: () {
                Navigator.pop(context);
                buildShowModalBottomSheet(context);
              },
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

  /// ✅ Bottom sheet for editing repetitions
  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 3,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 12),
              child: Text(
                'ضبط عدد مرات التكرار',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    'عدد مرات التكرار',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Color(0xFF80BCBD),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                // Add your edit logic here
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF80BCBD),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'تعديل مرات التكرار',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 300,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF80BCBD),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'الغاء',
                  style: TextStyle(
                    color: Color(0xFF80BCBD),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// ✅ Bottom sheet for delete confirmation
  Future<dynamic> buildShowDeleteDekeerBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 3,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 12),
              child: Text(
                "حذف من الورد اليومي",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    'هل انت متاكد من حذف هذا الذكر؟',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Color(0xFF80BCBD),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                // Add your delete logic here
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF80BCBD),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'حذف الذكر',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 300,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF80BCBD),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'الغاء',
                  style: TextStyle(
                    color: Color(0xFF80BCBD),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}