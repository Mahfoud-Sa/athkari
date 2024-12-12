import 'package:athkari/app/features/home/presentation/widgets/DrawerTitleWidet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        //    drawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextField(),
              Text("عدد الاذكار"),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
              dkeerWidget(),
            ],
          ),
        ));
  }
}

class dkeerWidget extends StatelessWidget {
  const dkeerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
      child: Column(children: [
        Text(
            "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ "),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            child: Row(
              children: [
                Icon(Icons.more_vert),
                Icon(Icons.share),
                Icon(Icons.copy),
              ],
            ),
          ),
          Container(
            child: Text('3'),
          ),
          Container(
            child: Text('عرض السند'),
          )
        ])
      ]),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
      flexibleSpace: Container(
        height: 100,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage("assets/images/patteren.png"))),
      ),
      actions: [
        Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/svgs/back_button.svg'),
          );
        }),
      ],
      automaticallyImplyLeading: false, // Remove default leading button
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "الورد اليومي",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 22, color: Colors.white),
        ),
      ));
}
