import 'package:athkari/app/features/on_bording/presentation/pages/on_bording_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onbording extends StatelessWidget {
  Onbording({super.key});
  var pageController = PageController();
  @override
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
          const SizedBox(
            height: 80,
          ),
          //skip button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      pageController.animateToPage(2,
                          curve: Curves.bounceIn,
                          duration: const Duration(seconds: 1));
                    },
                    child: Text(
                      "تخطي",
                      style: const TextStyle(
                          fontFamily: "IBMPlexSansArabic",
                          fontSize: 16,
                          color: Color.fromARGB(255, 157, 199, 168)),
                    )),
              ],
            ),
          ),
          //Page view
          SizedBox(
            //  color: Colors.amber,
            height: 430,
            width: MediaQuery.of(context).size.width - 120,
            child: PageView(
              controller: pageController,
              children: const [
                OnbordingPage(
                    imagePath: "assets/images/dua_hands_icon.png",
                    title: "قائمة غنية من      الاذكار والادعية",
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
          //Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIndicator(pageController),
              TextButton(
                  onPressed: () {
                    pageController.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn);
                  },
                  child: Text(
                    "التالي >",
                    style: const TextStyle(
                        fontFamily: "IBMPlexSansArabic",
                        fontSize: 16,
                        color: Color.fromARGB(255, 157, 199, 168)),
                  )),
            ],
          ),
        ],
      ),
    ));
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
