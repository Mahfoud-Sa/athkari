import 'package:athkari/app/core/methods/build_appbar_method.dart';
import 'package:athkari/app/core/methods/build_searchbae_method.dart';
import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit_state.dart';
import 'package:athkari/app/features/esnaad/presentation/widgets/esnad_card_widget.dart';
import 'package:athkari/app/features/home/presentation/pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EsnaadsPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var _esnadValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "الإسنادات"),
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          onPressed: () {
            buildEsnadModalBottomSheet(context);
          }),
      body: Column(
        children: [
          buildSearchBar(
            context,
            (query) {
              if (query.isNotEmpty) {
                context.read<EsnadsCubit>().search(query);
              } else {
                context.read<EsnadsCubit>().fetchData();
              }
            },
          ),
          Expanded(
              // Ensure the ListView takes the remaining space
              child: BlocListener<EsnadsCubit, EsnadState>(
            listenWhen: (previous, current) {
              return current == NotifeyEsnadState;
            },
            listener: (context, state) {
              // Show the SnackBar when the state is ShowMessageState
              if (state is NotifeyEsnadState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    duration: const Duration(seconds: 3),
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }
            },
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
                        esnadText: item.name!,
                        noOfRelatedDekres: 5,
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
          )),
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
          padding: EdgeInsets.symmetric(horizontal: 25),
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
                  'إضافة إسناد جديد',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Row(
                children: [
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: const Text(
                      'نص الإسناد',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Color.fromARGB(255, 128, 188, 189)),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5, // Allows the field to expand as the user types
                  controller: _esnadValue,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لايمكن اضافة سند فارغ, جرب كتابة نص الإسناد';
                    }
                    if (value.length == 150) {
                      return 'لا يجب ان يحتوي نص الاصناد على اكثر من 150حرف';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none, // Remove the visible border
                    ),
                    hintText: '...ادخل النص هنا',
                    filled: true, // Enable background color
                    fillColor: Color.fromARGB(
                        255, 214, 214, 213), // Set the background color
                    contentPadding: const EdgeInsets.symmetric(
                        // vertical: 100,
                        horizontal: 20), // Increased vertical padding
                  ),
                ),
              ),
              AddButtonWidget(
                buttonText: "إضافة",
                esnadValue: _esnadValue,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.read<EsnadsCubit>().addEsnad(
                          _esnadValue.text,
                        );
                  }
                },
                formKey: formKey,
              ),
              const SizedBox(
                height: 10,
              ),
              CancelButtonWidget(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class EsnaadCar2dWidget extends StatefulWidget {
//   EsnaadCar2dWidget(
//       {super.key,
//       required this.no_of_repeating,
//       required this.deker,
//       required this.saneed});
//   final double _fontsize = 18;
//   int no_of_repeating = 100;
//   String deker;
//   String saneed;
//   @override
//   State<EsnaadCardWidget> createState() => _EsnaadCardWidgetState();
// }

// class _EsnaadCar2dWidgetState extends State<EsnaadCardWidget> {
//   final ExpansionTileController _controller = ExpansionTileController();
//   int _no_of_repeating = 100;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     _no_of_repeating = widget.no_of_repeating;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           if (_no_of_repeating != 0) {
//             _no_of_repeating -= 1;
//           } else {
//             _no_of_repeating = widget.no_of_repeating;
//           }
//         });
//       },
//       borderRadius: BorderRadius.circular(15),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(25)),
//           border: GradientBoxBorder(
//             width: 1,
//             gradient: LinearGradient(colors: [
//               Color.fromARGB(255, 90, 202, 165),
//               Color.fromARGB(255, 178, 231, 93),
//             ]),
//           ),
//         ),
//         child: Column(
//           children: [
//             ExpansionTile(
//               onExpansionChanged: (isExpanded) {
//                 setState(() {}); // State change for any UI updates if needed
//               },
//               controller: _controller,
//               title: Text(
//                 textAlign: TextAlign.center,
//                 widget.deker,
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleMedium!
//                     .copyWith(fontSize: widget._fontsize),
//               ),
//               children: [
//                 Text(
//                   textAlign: TextAlign.center,
//                   "widget.saneed",
//                   style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                       fontSize: widget._fontsize, color: Colors.black12),
//                 ),
//               ],
//               showTrailingIcon: false,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // First Container with Icons
//                 Flexible(
//                   //    width: 50,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       PopupMenuButton(
//                         color:
//                             Colors.white, // Set the background color to white
//                         padding: EdgeInsets.all(0), // No padding
//                         //  onChanged: (value) {},
//                         icon: Expanded(
//                           child: Icon(
//                             Icons.more_vert,
//                             color: Colors.blueGrey,
//                           ),
//                         ),
//                         itemBuilder: (BuildContext context) {
//                           return [
//                             PopupMenuItem(
//                                 child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     buildShowModalBottomSheet(context);
//                                   },
//                                   child: Text(
//                                     "تعديل مرات التكرار",
//                                     style: TextStyle(
//                                       color: Color.fromARGB(255, 90, 202, 165),
//                                     ),
//                                   ),
//                                 ),
//                                 Icon(
//                                   Icons.add,
//                                   color: Color.fromARGB(255, 90, 202, 165),
//                                 )
//                               ],
//                             )),
//                             PopupMenuItem(
//                                 child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     buildShowDeleteDekeerBottomSheet(context);
//                                   },
//                                   child: Text(
//                                     "حذف من الورد اليومي",
//                                     style: TextStyle(
//                                       color: Color.fromARGB(255, 90, 202, 165),
//                                     ),
//                                   ),
//                                 ),
//                                 Icon(
//                                   Icons.delete,
//                                   color: Color.fromARGB(255, 90, 202, 165),
//                                 )
//                               ],
//                             )),
//                             //  PopupMenuItem(child: Text("حذف")),
//                           ];
//                         },
//                       ),
//                       Expanded(
//                         child: IconButton(
//                           padding: EdgeInsets.all(0), // No padding
//                           onPressed: () {
//                             Share.share(
//                                 'check out my website https://example.com');
//                           },
//                           icon: Icon(
//                             Icons.share,
//                             color: Colors.blueGrey,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: IconButton(
//                           padding: EdgeInsets.all(0), // No padding
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.copy,
//                             color: Colors.blueGrey,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: 120,
//                 ),
//                 // Second Container text
//                 Flexible(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             _controller.isExpanded
//                                 ? _controller.collapse()
//                                 : _controller.expand();
//                           });
//                         },
//                         icon: const Icon(Icons.arrow_drop_up_sharp),
//                       ),
//                       //  const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           'عرض السند',
//                           style: TextStyle(fontSize: widget._fontsize - 5),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
//     return showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (context) => SingleChildScrollView(
//         //  width: double.infinity,
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
//                 'ضبط عدد مرات اتكرار',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 24,
//                     fontWeight: FontWeight.w900),
//               ),
//             ),
//             const Row(
//               children: [
//                 Expanded(child: SizedBox()),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: const Text(
//                     'عدد مرات التكرار',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w800,
//                         fontSize: 22,
//                         color: Color.fromARGB(255, 128, 188, 189)),
//                   ),
//                 )
//               ],
//             ),
//             TempWidget(
//               noOfRepeating: 5,
//             ),
//             InkWell(
//               onTap: () {},
//               borderRadius: BorderRadius.circular(20),
//               child: Container(
//                 width: 300,
//                 height: 50,
//                 child: Center(
//                   child: const Text(
//                     'تعديل مرات التكرار',
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 128, 188, 189),
//                     borderRadius: BorderRadius.circular(30)),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             InkWell(
//               borderRadius: BorderRadius.circular(20),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 width: 300,
//                 height: 50,
//                 child: const Center(
//                   child: Text(
//                     'الغاء',
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 128, 188, 189),
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                         color: const Color.fromARGB(255, 128, 188, 189),
//                         width: 3),
//                     borderRadius: BorderRadius.circular(30)),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<dynamic> buildShowDeleteDekeerBottomSheet(BuildContext context) {
//     return showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (context) => SingleChildScrollView(
//         //  width: double.infinity,
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
//                 "حذف من الورد اليومي",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 24,
//                     fontWeight: FontWeight.w900),
//               ),
//             ),
//             const Row(
//               children: [
//                 Expanded(child: SizedBox()),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: const Text(
//                     'هل انت متاكد من حذف هذا الذكر؟',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w800,
//                         fontSize: 22,
//                         color: Color.fromARGB(255, 128, 188, 189)),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             InkWell(
//               onTap: () {},
//               borderRadius: BorderRadius.circular(20),
//               child: Container(
//                 width: 300,
//                 height: 50,
//                 child: Center(
//                   child: const Text(
//                     'حذف الذكر',
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 128, 188, 189),
//                     borderRadius: BorderRadius.circular(30)),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             InkWell(
//               borderRadius: BorderRadius.circular(20),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 width: 300,
//                 height: 50,
//                 child: const Center(
//                   child: Text(
//                     'الغاء',
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 128, 188, 189),
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                         color: const Color.fromARGB(255, 128, 188, 189),
//                         width: 3),
//                     borderRadius: BorderRadius.circular(30)),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
