import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:share_plus/share_plus.dart';

class DekarCardWidget extends StatefulWidget {
  const DekarCardWidget({
    super.key,
    required this.dhkar,
  });

  final DhkarEntity dhkar;
  final double _fontSize = 18;

  @override
  State<DekarCardWidget> createState() => _DekarCardWidgetState();
}

class _DekarCardWidgetState extends State<DekarCardWidget> {
  final ExpansionTileController _controller = ExpansionTileController();
  int _noOfRepeating = 0;

  @override
  void initState() {
    super.initState();
    _noOfRepeating =
        widget.dhkar.repetitions ?? 0; // Initialize repetition count
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _noOfRepeating = widget.dhkar.repetitions ?? 0;

          //  _noOfRepeating > 0
          //     ? _noOfRepeating - 1
          //     : widget.dhkar.repetitions ?? 0;
        });
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: GradientBoxBorder(
            width: 1,
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 90, 202, 165),
              Color.fromARGB(255, 178, 231, 93),
            ]),
          ),
        ),
        child: Column(
          children: [
            ExpansionTile(
              onExpansionChanged: (isExpanded) {
                // No need for setState here unless you have specific logic
              },
              controller: _controller,
              title: Text(
                textAlign: TextAlign.center,
                widget.dhkar.dhkar!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: widget._fontSize),
              ),
              showTrailingIcon: false,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "widget.dhkar.esnad.name" ??
                      "لا يوجد", // Replace with actual data if available
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: widget._fontSize,
                        color: Colors.black12,
                      ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Action Icons (More, Share, Copy)
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton(
                        color: Colors.white,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.blueGrey,
                        ),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _showEditRepetitionsBottomSheet(context);
                                    },
                                    child: const Text(
                                      "تعديل مرات التكرار",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 90, 202, 165),
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.add,
                                    color: Color.fromARGB(255, 90, 202, 165),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _showDeleteDhkarBottomSheet(context);
                                    },
                                    child: const Text(
                                      "حذف من الورد اليومي",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 90, 202, 165),
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 90, 202, 165),
                                  ),
                                ],
                              ),
                            ),
                          ];
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Share.share(
                              'check out my website https://example.com');
                        },
                        icon: const Icon(
                          Icons.share,
                          color: Colors.blueGrey,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // Implement copy functionality
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Repetition Count
                Container(
                  width: 100,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                    color: Color.fromARGB(255, 90, 202, 165),
                  ),
                  child: Center(
                    child: Text(
                      _noOfRepeating.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                // Expand/Collapse Button
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _controller.isExpanded
                                ? _controller.collapse()
                                : _controller.expand();
                          });
                        },
                        icon: const Icon(Icons.arrow_drop_up_sharp),
                      ),
                      Text(
                        'عرض السند',
                        style: TextStyle(fontSize: widget._fontSize - 5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Bottom Sheet for Editing Repetitions
  Future<void> _showEditRepetitionsBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                padding: EdgeInsets.symmetric(vertical: 12),
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
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      'عدد مرات التكرار',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Color.fromARGB(255, 128, 188, 189),
                      ),
                    ),
                  ),
                ],
              ),
              // Placeholder for repetition input widget
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  // Implement save functionality
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 128, 188, 189),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'تعديل مرات التكرار',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 128, 188, 189),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'الغاء',
                      style: TextStyle(
                        color: Color.fromARGB(255, 128, 188, 189),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom Sheet for Deleting Dhkar
  Future<void> _showDeleteDhkarBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'حذف من الورد اليومي',
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
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      'هل انت متأكد من حذف هذا الذكر؟',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Color.fromARGB(255, 128, 188, 189),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  // Implement delete functionality
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 128, 188, 189),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'حذف الذكر',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 128, 188, 189),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'الغاء',
                      style: TextStyle(
                        color: Color.fromARGB(255, 128, 188, 189),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
