import 'package:athkari/app/core/methods/success_snackbar.dart';
import 'package:athkari/app/core/widgets/custome_container.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/daily_wered/presentation/pages/daily_wered_Index_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:share_plus/share_plus.dart';

class DekharCardWidget extends StatefulWidget {
  const DekharCardWidget({super.key, required this.dekhar});
  final double _fontsize = 18;
  final DhkarEntity dekhar;
  @override
  State<DekharCardWidget> createState() => _DekarCardWidgetState();
}

class _DekarCardWidgetState extends State<DekharCardWidget> {
  final ExpansionTileController _controller = ExpansionTileController();
  int _no_of_repeating = 100;

  @override
  void initState() {
    
    super.initState();

    _no_of_repeating = widget.dekhar.repetitions ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_no_of_repeating != 0) {
            _no_of_repeating -= 1;
          } else {
            _no_of_repeating = widget.dekhar.repetitions ?? 0;
          }
        });
      },
      borderRadius: BorderRadius.circular(15),
      child: CustomeContainer(
        child: Column(
          children: [
            ExpansionTile(
              onExpansionChanged: (isExpanded) {
                setState(() {}); // State change for any UI updates if needed
              },
              controller: _controller,
              title: Text(
                textAlign: TextAlign.center,
                widget.dekhar.dhkar ?? "",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: widget._fontsize),
              ),
              showTrailingIcon: false,
              children: [
                Text(
                  widget.dekhar.esnad?.name ?? "",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: widget._fontsize, color: Colors.black12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // First Container with Icons
                Flexible(
                  //    width: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton(
                        color:
                            Colors.white, // Set the background color to white
                        padding: EdgeInsets.all(0), // No padding
                        //  onChanged: (value) {},
                        icon: Expanded(
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.blueGrey,
                          ),
                        ),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    buildShowModalBottomSheet(context);
                                  },
                                  child: Text(
                                    "تعديل مرات التكرار",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 90, 202, 165),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Color.fromARGB(255, 90, 202, 165),
                                )
                              ],
                            )),
                            PopupMenuItem(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    buildShowDeleteDekeerBottomSheet(context);
                                  },
                                  child: Text(
                                    "حذف من الورد اليومي",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 90, 202, 165),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 90, 202, 165),
                                )
                              ],
                            )),
                            //  PopupMenuItem(child: Text("حذف")),
                          ];
                        },
                      ),
                      // Expanded(
                      //   child: IconButton(
                      //     padding: EdgeInsets.all(0), // No padding
                      //     onPressed: () {
                      //       Clipboard.setData(ClipboardData(text: "deker"!));
                      //       successToastMessage(context, "تم نسخ النص");
                      //     },
                      //     icon: Icon(
                      //       Icons.copy,
                      //       color: Colors.blueGrey,
                      //     ),
                      //   ),
                      // ),

                      Expanded(
                        child: IconButton(
                          padding: EdgeInsets.all(0), // No padding
                          onPressed: () {
                            Share.share(
                                'check out my website https://example.com');
                          },
                          icon: Icon(
                            Icons.share,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),

                      Expanded(
                        child: IconButton(
                          padding: EdgeInsets.all(0), // No padding
                          onPressed: () {
                            // Clipboard.setData(ClipboardData(text: "deker"!));
                            // successToastMessage(context, "تم نسخ النص");
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 120,
                ),
                // Second Container text
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
                      //  const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'عرض السند',
                          style: TextStyle(fontSize: widget._fontsize - 5),
                        ),
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

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        //  width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
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
                'ضبط عدد مرات اتكرار',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: const Text(
                    'عدد مرات التكرار',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Color.fromARGB(255, 128, 188, 189)),
                  ),
                )
              ],
            ),
            TempWidget(
              noOfRepeating: 5,
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                child: Center(
                  child: const Text(
                    'تعديل مرات التكرار',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 128, 188, 189),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 300,
                height: 50,
                child: const Center(
                  child: Text(
                    'الغاء',
                    style: TextStyle(
                        color: Color.fromARGB(255, 128, 188, 189),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 128, 188, 189),
                        width: 3),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildShowDeleteDekeerBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        //  width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
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
                    fontWeight: FontWeight.w900),
              ),
            ),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: const Text(
                    'هل انت متاكد من حذف هذا الذكر؟',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Color.fromARGB(255, 128, 188, 189)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                child: Center(
                  child: const Text(
                    'حذف الذكر',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 128, 188, 189),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 300,
                height: 50,
                child: const Center(
                  child: Text(
                    'الغاء',
                    style: TextStyle(
                        color: Color.fromARGB(255, 128, 188, 189),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 128, 188, 189),
                        width: 3),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
