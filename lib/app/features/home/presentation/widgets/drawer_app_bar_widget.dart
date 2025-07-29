
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerAppBar extends StatelessWidget {
  const DrawerAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
          borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(30)),
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage("assets/images/patteren.png"))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          
          const SizedBox(
            width: 50,
          ),
          
          Text(
            'إعدادات التطبيق',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white, fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).closeDrawer();
                },
                icon: SvgPicture.asset('assets/svgs/back_button.svg'),
              );
            }),
          ),
     
        ],
      ),
    );
  }
}
