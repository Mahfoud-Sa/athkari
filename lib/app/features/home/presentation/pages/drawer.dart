import 'dart:html';

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
            ExpansionTile(
              expandedAlignment: Alignment.centerRight,
              trailing: Text(
                'ضبط الوقت والتاريخ',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black),
              ),
              leading: Icon(Icons.arrow_drop_up),
              title: Text('تلقائي'),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('تلقائي'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('مخصص'),
                  ],
                ),
              ],
            ),
            ExpansionPanelList(
              expandIconColor: Colors.amberAccent,
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) => Text('تلقائي'),
                  body: Text('تلقائي'),
                  isExpanded: true,
                ),
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) => Text('تلقائي'),
                  body: Text('تلقائي'),
                  isExpanded: false,
                ),
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) => Text('تلقائي'),
                  body: Text('تلقائي'),
                  isExpanded: false,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButton(
                  icon: Text(
                    'ضبط الوقت والتاريخ',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black),
                  ),
                  isExpanded: true,
                  alignment: Alignment.centerRight,
                  value: 0,
                  items: [
                    DropdownMenuItem(
                      child: Text("تلقائي"),
                      value: 0,
                    ),
                    DropdownMenuItem(child: Text("مخصص"), value: 1)
                  ],
                  onChanged: (value) {}),
            )
          ],
        ),
      ),
    );
  }
}
