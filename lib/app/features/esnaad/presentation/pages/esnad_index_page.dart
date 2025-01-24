import 'package:athkari/app/features/daily_wered/presentation/pages/dedher_Index_page.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit_state.dart';
import 'package:athkari/app/features/home/presentation/pages/drawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class EsnaadsPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var textEditingController_1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          onPressed: () {
            buildEsnadModalBottomSheet(context);
          }),
      body: Column(
        children: [
          _buildSearchBar(), // Keep the search bar at its place
          Expanded(
            // Ensure the ListView takes the remaining space
            child: BlocBuilder<EsnadsCubit, EsnadState>(
              builder: (context, state) {
                if (state is LoadingEsnadState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DoneEsnadState) {
                  return ListView.builder(
                    itemCount: state.esnads.length,
                    itemBuilder: (context, index) {
                      final item = state.esnads[index];
                      return EsnaadCardWidget(
                        deker: item.name!,
                        no_of_repeating: 5,
                      );
                    },
                  );
                } else if (state is EmptyEsnadState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Trigger a specific event
                        //  context.read<EsnadsCubit>().fetchData();
                      },
                      child: Text('إعاده المحاولة'),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildEsnadModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Form(
        key: formKey,
        child: SingleChildScrollView(
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
                  'أضافة اسناد جديد',
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
                      'اسم الاسناد',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Color.fromARGB(255, 128, 188, 189)),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: textEditingController_1,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none, // Remove the visible border
                    ),

                    hintText: 'اسم الاسناد',
                    filled: true, // Enable background color
                    fillColor: Colors.black12, // Set the background color
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20), // Adjust padding
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.read<EsnadsCubit>().AddEsnad(
                          textEditingController_1.text,
                        );
                  }
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 300,
                  height: 50,
                  child: Center(
                    child: const Text(
                      'اضافة',
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
      ),
    );
  }

  Padding _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        // onchange: (){

        // },
        keyboardType: TextInputType.text,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search), // Icon inside the border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none, // Remove the visible border
          ),

          hintText: '...بحث ',
          filled: true, // Enable background color
          fillColor: Colors.black12, // Set the background color
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 20), // Adjust padding
        ),
      ),
    );
  }
}

class EsnaadCardWidget extends StatefulWidget {
  EsnaadCardWidget({
    super.key,
    required this.no_of_repeating,
    required this.deker,
  });
  final double _fontsize = 18;
  int no_of_repeating = 100;
  String deker;

  @override
  State<EsnaadCardWidget> createState() => _EsnaadCardWidgetState();
}

class _EsnaadCardWidgetState extends State<EsnaadCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            widget.deker,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: widget._fontsize),
          ),
          Text(
            textAlign: TextAlign.center,
            "عدد الاذكار ${widget.no_of_repeating} ذكر",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: widget._fontsize, color: Colors.black12),
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

class EsnaadCar2dWidget extends StatefulWidget {
  EsnaadCar2dWidget(
      {super.key,
      required this.no_of_repeating,
      required this.deker,
      required this.saneed});
  final double _fontsize = 18;
  int no_of_repeating = 100;
  String deker;
  String saneed;
  @override
  State<EsnaadCardWidget> createState() => _EsnaadCardWidgetState();
}

class _EsnaadCar2dWidgetState extends State<EsnaadCardWidget> {
  final ExpansionTileController _controller = ExpansionTileController();
  int _no_of_repeating = 100;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _no_of_repeating = widget.no_of_repeating;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_no_of_repeating != 0) {
            _no_of_repeating -= 1;
          } else {
            _no_of_repeating = widget.no_of_repeating;
          }
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
                setState(() {}); // State change for any UI updates if needed
              },
              controller: _controller,
              title: Text(
                textAlign: TextAlign.center,
                widget.deker,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: widget._fontsize),
              ),
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "widget.saneed",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: widget._fontsize, color: Colors.black12),
                ),
              ],
              showTrailingIcon: false,
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.copy,
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

PreferredSize _buildAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(75), // Set custom height here
    child: AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/images/patteren.png"),
          ),
        ),
      ),
      automaticallyImplyLeading: false, // Remove default leading button
      centerTitle: true, // Keeps the title centered horizontally
      title: Text(
        "الاسنادات",
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/svgs/back_button.svg'),
          padding: EdgeInsets.zero, // Remove default padding
          constraints: const BoxConstraints(), // Remove default constraints
          alignment: Alignment.center, // Center vertically
        ),
      ],
    ),
  );
}
