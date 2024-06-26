import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage("assets/images/patteren.png"))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // First widget aligned to the right
                  const SizedBox(
                    width: 50,
                  ),
                  // Second widget centered
                  Text(
                    'إعدادات التطبيق',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white, fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).closeDrawer();
                        },
                        icon: SvgPicture.asset('assets/svgs/back_button.svg'),
                      );
                    }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'إعدادات التطبيق',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      dragStartBehavior: DragStartBehavior.start,
                      splashRadius: 250,
                      activeColor: const Color.fromARGB(255, 157, 199, 168),
                      value: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = !_value;
                        });
                      }),
                  Text(
                    'الوضع الليلي',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black),
                  )
                ],
              ),
            ),
            MyExpansionRadioTile(
              title: 'ضبط الوقت والتاريخ',
              selected: true,
              choices: ['تلقائي', 'مخصص'],
            ),
          ],
        ),
      ),
    );
  }
}

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
