import 'package:flutter/material.dart';
import 'package:shortcut_comics/widgets/home_button_group.dart';

class HomeLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context); // To receive screen size
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width :mediaQuery.size.width * 0.5,
          height :mediaQuery.size.height - mediaQuery.padding.top ,
          child: Center(
            child: Image.asset(
              'assets/shortcut.png', width: mediaQuery.size.width * 0.5,
              height: mediaQuery.size.height * 0.7,
            ),
          ),
        ),
        Container(
          width :(mediaQuery.size.width - mediaQuery.padding.bottom) * 0.35,
          child: Center(
            child: HomeButtonGroup(0.25),
          ),
        ),
      ],
    );
  }
}
