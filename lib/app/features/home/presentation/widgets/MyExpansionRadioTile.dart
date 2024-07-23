import 'package:flutter/material.dart';

class MyExpansionRadioTile extends StatefulWidget {
  MyExpansionRadioTile(
      {super.key,
      required this.title,
      this.selected = true,
      required this.choices});
  final String title;
  bool selected;
  final List<String> choices;
  @override
  State<MyExpansionRadioTile> createState() => _MyExpansionRadioTileState();
}

class _MyExpansionRadioTileState extends State<MyExpansionRadioTile> {
  bool isExpansion = true;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (value) {
        setState(() {
          isExpansion = !isExpansion;
        });
      },
      expandedAlignment: Alignment.centerRight,
      trailing: Text(widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
      leading: isExpansion
          ? const Icon(
              Icons.arrow_drop_up,
              size: 28,
              color: Color.fromARGB(255, 157, 199, 168),
            )
          : const Icon(
              size: 28,
              color: Color.fromARGB(255, 157, 199, 168),
              Icons.arrow_drop_down),
      title: Text(
        widget.selected ? widget.choices[0] : widget.choices[1],
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontSize: 18, fontWeight: FontWeight.normal),
      ),
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          titleAlignment: ListTileTitleAlignment.top,
          title: Text(
            widget.choices[0],
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black),
            textAlign: TextAlign.right,
          ),
          trailing: Radio(
              hoverColor: const Color.fromARGB(255, 157, 199, 168),
              activeColor: const Color.fromARGB(255, 157, 199, 168),
              value: widget.selected,
              groupValue: true,
              onChanged: (value) {
                setState(() {
                  widget.selected = !widget.selected;
                });
              }),
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          titleAlignment: ListTileTitleAlignment.top,
          title: Text(
            widget.choices[1],
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black),
            textAlign: TextAlign.right,
          ),
          trailing: Radio(
              hoverColor: const Color.fromARGB(255, 157, 199, 168),
              activeColor: const Color.fromARGB(255, 157, 199, 168),
              value: widget.selected,
              groupValue: false,
              onChanged: (value) {
                setState(() {
                  widget.selected = !widget.selected;
                }); //selected value
              }),
        ),
      ],
    );
  }
}
