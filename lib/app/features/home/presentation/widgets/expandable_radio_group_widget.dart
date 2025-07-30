import 'package:flutter/material.dart';
import 'dart:ui' as ui; // For TextDirection

class ExpandableRadioGroup extends StatefulWidget {
  const ExpandableRadioGroup({
    super.key,
    required this.title,
    required this.options,
    this.initialSelected = true,
    this.activeColor = const Color.fromARGB(255, 157, 199, 168),
    this.isRTL = true, // Added RTL control parameter
  });

  final String title;
  final List<String> options;
  final bool initialSelected;
  final Color activeColor;
  final bool isRTL; // New parameter to control direction

  @override
  State<ExpandableRadioGroup> createState() => _ExpandableRadioGroupState();
}

class _ExpandableRadioGroupState extends State<ExpandableRadioGroup> {
  late bool _isExpanded;
  late bool _selectedValue;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
    _selectedValue = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.isRTL ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                    color: Color(0xff3a3a3a),
                    fontWeight: FontWeight.w400,
                    fontFamily: "IBMPlexSansArabic",
                    fontStyle:  FontStyle.normal,
                    fontSize: 16.0
                ),
                //textAlign: widget.isRTL ? TextAlign.right : TextAlign.left,
              ),
            ),
            
            // Expandable Radio Section
            ExpansionTile(
              onExpansionChanged: (expanded) => setState(() => _isExpanded = expanded),
              expandedAlignment: widget.isRTL ? Alignment.centerRight : Alignment.centerLeft,
              trailing: _buildTrailingIcon(),
              title: _buildSelectedOptionText(),
              children: _buildRadioOptions(),
              tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailingIcon() {
    return Icon(
      _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
      size: 28,
      color: widget.activeColor,
    );
  }

  Widget _buildSelectedOptionText() {
    return Text(
      _selectedValue ? widget.options[0] : widget.options[1],
      style:   TextStyle(
    color:   Color(0xff3a3a3a),
    fontWeight: FontWeight.w400,
    fontFamily: "IBMPlexSansArabic",
    fontStyle:  FontStyle.normal,
    fontSize: 16.0
),
textAlign: TextAlign.right
     // textAlign: widget.isRTL ? TextAlign.right : TextAlign.left,
    );
  }

  List<Widget> _buildRadioOptions() {
    return widget.options.asMap().entries.map((entry) {
      final index = entry.key;
      final option = entry.value;
      final isSelected = _selectedValue == (index == 0);

      return Directionality(
        textDirection: widget.isRTL ? ui.TextDirection.rtl : ui.TextDirection.ltr,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          titleAlignment: ListTileTitleAlignment.top,
          title: Text(
            option,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black),
            textAlign: widget.isRTL ? TextAlign.right : TextAlign.left,
          ),
          trailing: Radio<bool>(
            value: index == 0,
            groupValue: _selectedValue,
            onChanged: (value) => setState(() => _selectedValue = value ?? false),
            hoverColor: widget.activeColor,
            activeColor: widget.activeColor,
          ),
        ),
      );
    }).toList();
  }
}