import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/core/widgets/custome_container.dart';
import 'package:athkari/app/features/daily_wered/presentation/pages/dedher_Index_page.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:share_plus/share_plus.dart';

class EsnaadCardWidget extends StatefulWidget {
  var formKey = GlobalKey<FormState>();
  var _esnadValue = TextEditingController();

  EsnaadCardWidget({
    super.key,
    required this.noOfRelatedDekres,
    required this.esnadText,
  });
  final double _fontsize = 18;
  int noOfRelatedDekres = 100;
  String esnadText;

  @override
  State<EsnaadCardWidget> createState() => _EsnaadCardWidgetState();
}

class _EsnaadCardWidgetState extends State<EsnaadCardWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //esnad text
          Text(
            textAlign: TextAlign.center,
            maxLines: 6,
            widget.esnadText,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: widget._fontsize),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Align items to the start
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center vertically
                mainAxisSize: MainAxisSize.min, // Ensure no extra space
                children: [
                  InkWell(
                    child: PopupMenuButton(
                      menuPadding: EdgeInsets.zero,
                      color: Colors.white, // Set background color to white
                      padding: EdgeInsets.zero, // Remove default padding
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.blueGrey,
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopuoMenuAddMethod(context),
                          PopupMenuDeleteMethod(context),
                        ];
                      },
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    onTap: () {
                      Share.share('check out my website https://example.com');
                    },
                    child: Icon(
                      Icons.share,
                      color: Colors.blueGrey,
                    ),
                  ),
                  //  SizedBox(width: 4), // Optional spacing, adjust as needed
                  InkWell(
                    radius: 300,
                    borderRadius: BorderRadius.all(Radius.circular(150)),
                    onTap: () {
                      // Add copy functionality
                    },
                    child: Icon(
                      Icons.copy,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ), // show Number text

              //relatedDekres
              Text(
                textAlign: TextAlign.center,
                " عدد الاذكار المرتيطة ${widget.noOfRelatedDekres} ذكر",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: widget._fontsize, color: Colors.black12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<dynamic> PopupMenuDeleteMethod(BuildContext context) {
    return PopupMenuItem(
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
          ),
        ],
      ),
    );
  }

  PopupMenuItem<dynamic> PopuoMenuAddMethod(BuildContext context) {
    return PopupMenuItem(
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
          ),
        ],
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
                'تعديل النص',
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
                    'تعديل النص',
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
                    'تعديل النص',
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
                "حذف",
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
                    'هل انت متاكد من حذف هذا الاسناد؟',
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
            //      AddButtonWidget(formKey: formKey, esnadValue: esnadValue),
            CancelButtonWidget(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
