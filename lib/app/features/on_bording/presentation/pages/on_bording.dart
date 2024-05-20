import 'package:flutter/material.dart';

class OnbordingPage extends StatelessWidget {
  const OnbordingPage({super.key});

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
        children: [
          const SizedBox(height: 170),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                TextButton(onPressed: () {}, child: const Text("تخطي")),
              ],
            ),
          ),
          Image.asset("assets/images/dua_hands_icon.png"),
          SizedBox(
            width: MediaQuery.of(context).size.width - 70,
            child: const Text(
              "قائمة غنية من الاذكار والادعية",
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 32),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 70,
            child: const Text(
                style: TextStyle(fontSize: 16, color: Colors.black45),
                textAlign: TextAlign.end,
                "تصفح مجموعة متنوعة من الاذكار والادعية واضفها الى وردك اليومي او شاركها عبر مواقع التواصل الاجتماعي"),
          ),
          SizedBox(
            height: 120,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text('التالي'), Text('التالي')],
          )
        ],
      ),
    ));
  }
}
