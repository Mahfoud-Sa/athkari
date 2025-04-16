import 'package:athkari/app/features/categories/data/modules/category_models.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/presentation/pages/category_index_page.dart';
import 'package:athkari/app/features/daily_wered/presentation/pages/daily_wered_Index_page.dart';
import 'package:athkari/app/features/esnaad/presentation/pages/esnad_index_page.dart';
import 'package:athkari/app/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/home_page_cubit_states.dart';
import 'package:athkari/app/features/home/presentation/pages/drawer.dart';
import 'package:athkari/app/features/home/presentation/widgets/dekaar_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('MMMM dd EEE').add_jm();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        drawer: DrawerWidget(),
        body: 
             SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    _buildDailyDkeer(context),
                    const SizedBox(
                      height: 20,
                    ),
                    // section of show all
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryIndexPage(),
                                  ));
                            },
                            child: Text(
                              'عرض الكل',
                              style:
                                  Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: Colors.black,
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                      ),
                            ),
                          ),
                          Text(
                            'أقسام الأذكار',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
            
                    BlocBuilder<HomepageCubit, HomePageCubitStates>(
                      builder: (context, state) {
                        if (state is LoadingHomePageState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is DoneHomePageState) {
                          return _buildDekarSection(state);
                        } else if (state is EmptyHomePageState) {
                          return Center(
                            child: Text(state.message),
                          );
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.share),
                          ),
                          Text(
                            'ذكر اليوم',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<HomepageCubit, HomePageCubitStates>(
                      buildWhen: (previous, current) => current is doneDekkharState,
                      builder: (context,state) {
                        if(state is doneDekkharState){
                          return _buildTodayDekarSection(context,state);

                        }else{
                          return CircularProgressIndicator();
                        }
                        
                      }
                     
                      )
                    ,
                    const SizedBox(
                      height: 20,
                    ),
                    _buildEsnadatSection(context),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          
        );
  }

  Container _buildEsnadatSection(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 93, 137, 138),
              Color.fromARGB(255, 213, 255, 220),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EsnaadsPage(),
                    ));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  'عرض الاسنادات',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            Text(
                textAlign: TextAlign.center,
                'بالاسناد,تحفظ السنة وتصان\nمن الدس والتحريف والوضع',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 18, color: Colors.white)),
          ],
        ));
  }

  Container _buildTodayDekarSection(BuildContext context,doneDekkharState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: GradientBoxBorder(
              width: 1,
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 90, 202, 165),
                Color.fromARGB(255, 178, 231, 93),
              ]))),
      child: Center(
        child: Text(
            textAlign: TextAlign.center,
            state.message,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 22)),
      ),
    );
  }

  SingleChildScrollView _buildDekarSection(DoneHomePageState categoriesList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Text(categoriesList.categories.length.toString()),
          for (CategoryEntity category in categoriesList.categories)
            DekaarContainerWidget(
              text: category.name!,
            ),
        ],
      ),
    );
  }

  Container _buildDailyDkeer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width - 60,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/patteren.png"))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            'الورد اليومي',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white, fontSize: 32),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'سبحان الله والحمدلله \nولا اله  الا الله والله أكبر',
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 95,
            height: 95,
            decoration: BoxDecoration(
                border: const Border(
                  right: BorderSide(
                    color: Colors.green,
                    width: 3,
                  ),
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: Text(
              "30%",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 35,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DedherIndexPage(),
                        ));
                  },
                  child: Text(
                    "عرض الكل",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                        ),
                  ),
                ),
                Text(
                  "تم اكمال 35 من 50 ذكر",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.settings),
          iconSize: 36,
          color: const Color.fromARGB(255, 117, 192, 192),
        );
      }),
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
