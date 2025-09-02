import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/features/daily_wered/presentation/pages/daily_wered_Index_page.dart';
import 'package:athkari/app/features/home/domain/usecase/reset_database_usecase.dart';
import 'package:athkari/app/features/home/presentation/pages/home_page.dart';
import 'package:athkari/app/features/on_bording/presentation/pages/on_bording_page.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onbording extends StatefulWidget {
  Onbording({super.key});
  var pageController = PageController();

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {
        _currentPage = widget.pageController.page!.toInt();
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/onboarding_screen.png"))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //skip button
            const SizedBox(
              height: 80,
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  _currentPage != 2
                      ? TextButton(
                          onPressed: () {
                            widget.pageController.animateToPage(2,
                                curve: Curves.bounceIn,
                                duration: const Duration(seconds: 1));
                          },
                          child: const Text(
                            "تخطي",
                            style: TextStyle(
                                fontFamily: "IBMPlexSansArabic",
                                fontSize: 16,
                                color: Color.fromARGB(255, 157, 199, 168)),
                          ))
                      : const Text(''),
                ],
              ),
            ),
            //Page view
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: PageView(
                  controller: widget.pageController,
                  children: const [
                    OnbordingPage(
                        imagePath: "assets/images/dua_hands_icon.png",
                        title: "قائمة غنية من\nالاذكار والادعية",
                        description:
                            "تصفح مجموعة متنوعة من الاذكار والادعية واضفها الى وردك اليومي او شاركها عبر مواقع التواصل الاجتماعي"),
                    OnbordingPage(
                        imagePath: "assets/images/tasbeeh_icon.png",
                        title: "حافظ على وردك من الأذكار",
                        description:
                            "لا تفوت ورداً واحد مع تطبيق أذكاري,اجعل ذكر الله رفيقك الدائم في كل وقت."),
                    OnbordingPage(
                        imagePath: "assets/images/vector.png",
                        title: "بالاسناد تحفظ السنه وتصان",
                        description:
                            "لتكن على يقين من صحة ما تقراء,جميع الاذكار والادعية مدعومه باسنادها لضمان صحتها وموثوقيتها.")
                  ],
                ),
              ),
            ),
            //Indicator
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIndicator(widget.pageController),
                  _currentPage != 2
                      ? TextButton(
                          onPressed: () {
                            widget.pageController.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeIn);
                          },
                          child: const Text(
                            "التالي >",
                            style: TextStyle(
                                fontFamily: "IBMPlexSansArabic",
                                fontSize: 16,
                                color: Color.fromARGB(255, 157, 199, 168)),
                          ))
                      : TextButton(
                          onPressed: () async {
                            SharedPreferences localStorage =
                                await SharedPreferences.getInstance();
                            localStorage.setBool("showOnBordingPages", false);
                            // Reset the database
                            await getIt<ResetDatabaseUsecase>.call();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ));
                          },
                          child: const Text(
                            "ابدا",
                            style: TextStyle(
                                fontFamily: "IBMPlexSansArabic",
                                fontSize: 16,
                                color: Color.fromARGB(255, 157, 199, 168)),
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SmoothPageIndicator _buildIndicator(PageController controller) {
    return SmoothPageIndicator(
      controller: controller,

      count: 3,
      effect: const SlideEffect(
          spacing: 8.0,
          dotWidth: 12.0,
          dotHeight: 5.0,
          paintStyle: PaintingStyle.fill,
          strokeWidth: 1.5,
          activeDotColor: Colors.green,
          dotColor:
              Color.fromARGB(255, 184, 227, 186)), // your preferred effect
    );
  }
}
