import 'package:athkari/app/core/methods/build_appbar_method.dart';
import 'package:athkari/app/core/methods/build_searchbae_method.dart';
import 'package:athkari/app/core/widgets/dekar_card_widget.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_state.dart';
import 'package:athkari/app/features/daily_wered/presentation/pages/side_title_widget.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/gradient_borders.dart';

class DedherIndexPage extends StatelessWidget {
  const DedherIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, "الورد اليومي"),
        // floatingActionButton: FloatingActionButton.small(
        //     child: Icon(Icons.add),
        //     onPressed: () {
        //       buildEsnadModalBottomSheet(context);
        //     }),
        body: Column(children: [
          buildSearchBar(
            context,
            (query) {
              if (query.isNotEmpty) {
                //context.read<EsnadsCubit>().search(query);
              } else {
                // context.read<EsnadsCubit>().fetchData();
              }
            },
          ),
          Expanded(
            //    child: BlocBuilder<DailyWereCubit, DailyWeredCubitStates>(
            //  BlocBuilder<CategoryCubit, CatogeryState>
            // listenWhen: (previous, current) {
            //   return current == NotifeyDailyWeredCubitState;
            // },
            // listener: (context, state) {
            //   // Show the SnackBar when the state is ShowMessageState
            //   if (state is NotifeyDailyWeredCubitState) {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         content: Text(state.message),
            //         duration: const Duration(seconds: 3),
            //         backgroundColor: Colors.blueAccent,
            //       ),
            //     );
            //   }
            // },
            child: BlocBuilder<DailyWereCubit, DailyWeredCubitStates>(
                builder: (context, state) {
              if (state is LoadingDailyWeredState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is DoneDailyWeredState) {
                return ListView(
                  children: [
                    // Iterate through the doneState list to generate DekarCardWidgets
                    SideTitle(
                      title: "عدد الاذكار",
                      count: state.athkari.length,
                    ),
                    for (var item in state.athkari)
                      DekarDailyWereCardWidget(
                        dhkar: item,
                        //  no_of_repeating: item.repetitions as int,
                        // deker: item.dhkar!,
                        // saneed: item.esnad!.name.toString(),
                      ),
                  ],
                );
              } else {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Trigger a specific event
                      context.read<EsnadsCubit>().fetchData();
                    },
                    child: Text('إعاده المحاولة'),
                  ),
                );
              }
            }),
          ),
        ]));
  }

  // Future<dynamic> buildEsnadModalBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) => Form(
  //       key: formKey,
  //       child: SingleChildScrollView(
  //         padding: EdgeInsets.symmetric(horizontal: 25),
  //         child: Column(
  //           children: [
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Container(
  //               height: 3,
  //               width: 80,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(30),
  //                 color: Colors.black,
  //               ),
  //             ),
  //             const Padding(
  //               padding: EdgeInsets.only(top: 8, bottom: 12),
  //               child: Text(
  //                 'إضافة إسناد جديد',
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 24,
  //                     fontWeight: FontWeight.w600),
  //               ),
  //             ),
  //             const Row(
  //               children: [
  //                 Expanded(child: SizedBox()),
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 8.0),
  //                   child: const Text(
  //                     'نص الإسناد',
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.w600,
  //                         fontSize: 22,
  //                         color: Color.fromARGB(255, 128, 188, 189)),
  //                   ),
  //                 )
  //               ],
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: TextFormField(
  //                 maxLines: 5, // Allows the field to expand as the user types
  //                 controller: _esnadValue,
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'لايمكن اضافة سند فارغ, جرب كتابة نص الإسناد';
  //                   }
  //                   if (value.length == 150) {
  //                     return 'لا يجب ان يحتوي نص الاصناد على اكثر من 150حرف';
  //                   }
  //                   return null;
  //                 },
  //                 keyboardType: TextInputType.text,
  //                 textAlign: TextAlign.right,
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(25),
  //                     borderSide: BorderSide.none, // Remove the visible border
  //                   ),
  //                   hintText: '...ادخل النص هنا',
  //                   filled: true, // Enable background color
  //                   fillColor: Color.fromARGB(
  //                       255, 214, 214, 213), // Set the background color
  //                   contentPadding: const EdgeInsets.symmetric(
  //                       // vertical: 100,
  //                       horizontal: 20), // Increased vertical padding
  //                 ),
  //               ),
  //             ),
  //             AddButtonWidget(
  //               buttonText: "إضافة",
  //               esnadValue: _esnadValue,
  //               onTap: () {
  //                 if (formKey.currentState!.validate()) {
  //                   context.read<EsnadsCubit>().addEsnad(
  //                         _esnadValue.text,
  //                       );
  //                 }
  //               },
  //               formKey: formKey,
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             CancelButtonWidget(),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class TempWidget extends StatefulWidget {
  int noOfRepeating;

  TempWidget({
    super.key,
    required this.noOfRepeating,
  });

  @override
  State<TempWidget> createState() => _TempWidgetState();
}

class _TempWidgetState extends State<TempWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.noOfRepeating.toString());
  }

  void _updateValue(int change) {
    setState(() {
      widget.noOfRepeating += change;
      _controller.text = widget.noOfRepeating.toString();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => _updateValue(-1),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 128, 188, 189),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                '-',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: 100,
          child: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.number,
            readOnly: true, // Prevent manual editing
          ),
        ),
        InkWell(
          onTap: () => _updateValue(1),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 128, 188, 189),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                '+',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Container _buildTodayDekarSection(BuildContext context) {
  final double _fontsize = 18;
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: GradientBoxBorder(
              width: 1,
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 90, 202, 165),
                Color.fromARGB(255, 178, 231, 93),
              ]))),
      child: Column(
        children: [
          ExpansionTile(
            title: Text(
                textAlign: TextAlign.center,
                "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ ",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: _fontsize)),
            children: [
              Text(
                  textAlign: TextAlign.center,
                  "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ ",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: _fontsize, color: Colors.black12)),
            ],
            showTrailingIcon: false,
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, // Space around the children
            children: [
              // First Container with Icons
              Flexible(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center icons within this container
                    children: [
                      Icon(Icons.more_vert),
                      SizedBox(width: 8), // Add space between icons
                      Icon(Icons.share),
                      SizedBox(width: 8), // Add space between icons
                      Icon(Icons.copy),
                    ],
                  ),
                ),
              ),

              // Second Container with Number
              Container(
                width: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  color: Color.fromARGB(255, 90, 202, 165),
                ),
                child: Center(
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),

              // Third Container with Arrow and Text
              Flexible(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center content within this container
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_drop_up_sharp),
                      ),
                      SizedBox(width: 8), // Add space between icon and text
                      Text(
                        'عرض السند',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}
