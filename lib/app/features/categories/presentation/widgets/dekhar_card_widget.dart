import 'package:athkari/app/core/methods/success_snackbar.dart';
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
            /// ✅ ExpansionTile is fine
            ExpansionTile(
              onExpansionChanged: (_) => setState(() {}),
              controller: _controller,
              title: Text(
                widget.dekhar.dhkar ?? "",
                textAlign: TextAlign.center,
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
                        fontSize: widget._fontsize,
                        color: Colors.black12,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            /// ✅ Bottom action row (Fixed overflow)
            Row(
              children: [
                /// LEFT SIDE ACTIONS
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PopupMenuButton(
                        color: Colors.white,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.blueGrey,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      buildShowModalBottomSheet(context),
                                  child: const Text(
                                    "تعديل مرات التكرار",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 90, 202, 165),
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
                                  onTap: () =>
                                      buildShowDeleteDekeerBottomSheet(context),
                                  child: const Text(
                                    "حذف من الورد اليومي",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 90, 202, 165),
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
                        ],
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Share.share(
                            'check out my website https://example.com'),
                        icon: const Icon(Icons.share, color: Colors.blueGrey),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // Clipboard.setData(ClipboardData(text: "deker"!));
                          // successToastMessage(context, "تم نسخ النص");
                        },
                        icon: const Icon(Icons.add, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),

                /// RIGHT SIDE ACTIONS
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                      Flexible(
                        child: Text(
                          'عرض السند',
                          style: TextStyle(fontSize: widget._fontsize - 5),
                          overflow: TextOverflow.ellipsis,
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

  /// ✅ Bottom sheet for editing
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
                      color: Color.fromARGB(255, 128, 188, 189),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // TempWidget(...) <-- your widget here
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 128, 188, 189),
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
                    color: const Color.fromARGB(255, 128, 188, 189),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'الغاء',
                  style: TextStyle(
                    color: Color.fromARGB(255, 128, 188, 189),
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

  /// ✅ Bottom sheet for delete
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
                      color: Color.fromARGB(255, 128, 188, 189),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 128, 188, 189),
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
                    color: const Color.fromARGB(255, 128, 188, 189),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'الغاء',
                  style: TextStyle(
                    color: Color.fromARGB(255, 128, 188, 189),
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
