import 'package:flutter/material.dart';
import 'package:shortcut_comics/widgets/home_button_group.dart';

class HomePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context); // To receive screen data
    return Column(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/shortcut.png', width: mediaQuery.size.width * 0.6,

              ),
            ],
          ),
        ),
        HomeButtonGroup(0.8),
      ],
    );
  }
}
