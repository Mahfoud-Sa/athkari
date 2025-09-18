import 'package:athkari/app/core/widgets/empty_data_widget.dart';
import 'package:athkari/app/core/widgets/waiting_animated_widget.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/features/categories/presentation/pages/category_index_page.dart';
import 'package:athkari/app/features/daily_wered/presentation/pages/daily_wered_Index_page.dart';
import 'package:athkari/app/features/esnaad/presentation/pages/esnad_index_page.dart';
import 'package:athkari/app/features/home/presentation/cubit/daily_wered_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/daily_wered_cubit_status.dart';
import 'package:athkari/app/features/home/presentation/cubit/reset_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/reset_cubit_states.dart';
import 'package:athkari/app/features/home/presentation/cubit/today_dekhar_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/today_dekhar_cubit_states.dart';
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
        body:SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                     _buildDailyweredProgressSection(),
                    const SizedBox(
                      height: 20,
                    ),

                    _buildCategorySection(context),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildTodaydekharSection(),
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



  BlocBuilder<TodayDekharCubit, TodayDekharCubitStates> _buildTodaydekharSection() {
    return BlocBuilder<TodayDekharCubit, TodayDekharCubitStates>(
                   
                    builder: (context,state) {
                      if(state is doneDekkharState){
                        return _buildTodayDekarSection(context,state);

                      }else{
                        return CircularProgressIndicator();
                      }
                      
                    }
                   
                    );
  }

  Column _buildCategorySection(BuildContext context) {
    return Column(
children: [
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
                  BlocListener<ResetCubit, ResetCubitState>(
  listener: (context, state) {
    if (state is DoneState) {
      // 👉 Tell CategoryCubit to refresh its stream
      context.read<CategoryCubit>().fetchData();
    }
  },
  child: StreamBuilder<List<CategoryEntity>>(
    stream: context.read<CategoryCubit>().categoriesStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }

      final categories = snapshot.data!;

      if (categories.isEmpty) {
        return emptyDataWidget(smallSize: true);
      }

      return _buildDekarDoneState(
        DoneCategoryState(categories), // ✅ reuse your existing widget builder
      );
    },
  ),
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
                    ],
                  );
  }

  BlocBuilder<DailyWeredProgressCubit, DailyWeredCubitStatus> _buildDailyweredProgressSection() {
    return BlocBuilder<DailyWeredProgressCubit, DailyWeredCubitStatus>(
                    builder: (context, state) {
                      if (state is LoadingDailyWeredState) {
                      return _buildWaitingDailyDekharState(context);
                      } else if (state is DoneDailyWeredState) {
                        return _buildDailyDkeer(context,state);
                      } else if (state is ErrorDailyWeredState) {
                        return _buildErrorDailyDekharState(
                          context, 
                          errorMessage: state.message,
                          onRetry: () {
                            // Retry fetching data
                            context.read<DailyWeredProgressCubit>().fetchData();
                          },
                        );
                      }
                    
                        return _buildWaitingDailyDekharState(context);
                      
                    },
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

  SingleChildScrollView _buildDekarDoneState(DoneCategoryState categoriesList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Text(categoriesList.categories.length.toString()),
          for (CategoryEntity category in categoriesList.catogories)
            DekaarContainerWidget(
              text: category.name!,
            ),
        ],
      ),
    );
  }

  Container _buildDailyDkeer(BuildContext context,DoneDailyWeredState state) {
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
          state.message ?? "لا يوجد ورد يومي",
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
              "${state.percentage}%",
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
                  "تم اكمال ${state.completedWered} من ${state.completedWered} ذكر",
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


  Container _buildWaitingDailyDekharState(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20,right: 10,left: 10),
      width: MediaQuery.of(context).size.width - 10,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/patteren.png"))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         
         
          const SizedBox(
            height: 30,
          ),
          Text(
           "الورد اليومي",
            style: TextStyle(
    color:  Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: "IBMPlexSansArabic",
    fontStyle:  FontStyle.normal,
    fontSize: 24.0)),
          const SizedBox(
            height: 80,
          ),
           AnimatedDots(white: true,),
          const SizedBox(
            height: 100,
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
                 Text(
                    "...جاري التحميل",
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

Container _buildErrorDailyDekharState(BuildContext context, {required String errorMessage, required VoidCallback onRetry}) {
  return Container(
    margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
    width: MediaQuery.of(context).size.width - 10,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("assets/images/patteren.png")
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 30),
        Text(
          "الورد اليومي",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: "IBMPlexSansArabic",
            fontStyle: FontStyle.normal,
            fontSize: 24.0,
          ),
        ),
        const SizedBox(height: 40),
        // Error icon instead of loading animation
        Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 60,
        ),
        const SizedBox(height: 20),
        // Error message
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: "IBMPlexSansArabic",
            ),
          ),
        ),
        const SizedBox(height: 40),
        // Retry button
        ElevatedButton(
          onPressed: onRetry,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red, // Text color
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            "إعادة المحاولة",
            style: TextStyle(
              fontFamily: "IBMPlexSansArabic",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 60),
        Container(
          height: 35,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "حدث خطأ",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
}
