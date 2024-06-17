import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('MMMM dd EEE').add_jm();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const Center(child: Text('Hellow word')),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.settings),
        iconSize: 36,
        color: const Color.fromARGB(255, 117, 192, 192),
      ),
      title: Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "اسعد الله صباحك بالخيرات",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                formatter.format(now),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black45),
              ),
            ],
          )),
    );
  }
}
