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

class _DekarCardWidgetState extends State<DekharCardWidget> {
  bool _expanded = false;

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
              
              // Esnad text (appears when expanded)
              if (_expanded) ...[
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.dekhar.esnad?.name ?? "",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: widget._fontsize - 2,
                          color: Colors.black54,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              
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
            width: 96, // Fixed width for the action buttons area
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
          
          // Right actions - expand/collapse with tight spacing
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: const Color(0xFF80BCBD),
                    size: 18,
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
                // buildShowDeleteDekeerBottomSheet(context);
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
                // buildShowModalBottomSheet(context);
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
      onTap: () => setState(() => _expanded = !_expanded),
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

  // Keep your existing bottom sheet methods here
  // Future<dynamic> buildShowModalBottomSheet(BuildContext context) { ... }
  // Future<dynamic> buildShowDeleteDekeerBottomSheet(BuildContext context) { ... }
  
}