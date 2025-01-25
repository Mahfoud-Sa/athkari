import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/local_daily_were_cubit_cubit.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/local_daily_were_cubit_state.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:athkari/app/features/daily_wered/presentation/widgets/dekar_card_widget.dart';

import 'package:gradient_borders/gradient_borders.dart';

class DedherIndexPage extends StatelessWidget {
  const DedherIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: BlocBuilder<LocalDailyWereCubitCubit, LocalDailyWeredCubitStates>(
            builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DoneState) {
            return ListView(
              children: [
                _buildSearchBar(context),
                SideTitle(
                  title: "عدد الاذكار",
                  count: state.total,
                ),

                // Iterate through the doneState list to generate DekarCardWidgets
                for (var item in state.athkari)
                  DekarCardWidget(
                    no_of_repeating: item['repetitions'] as int,
                    deker: item['dhaker'],
                    saneed: item['esnaad_id'].toString(),
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
        }));
  }

  Padding _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        onChanged: (value) {
          context.read<LocalDailyWereCubitCubit>().Search(value);
        },
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

class SideTitle extends StatelessWidget {
  const SideTitle({
    super.key,
    required this.count,
    required this.title,
  });
  final int count;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
          alignment: Alignment.centerRight, child: Text("${title} : ${count}")),
    );
  }
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
        "الورد اليومي",
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
