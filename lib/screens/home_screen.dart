import 'package:flutter/material.dart';
import 'package:shortcut_comics/screens/comics_screen.dart';
import 'package:shortcut_comics/screens/favorites_screen.dart';
import 'package:shortcut_comics/screens/search_screen.dart';
import 'package:shortcut_comics/screens/search_text_screen.dart';
import 'package:shortcut_comics/widgets/home_button_group.dart';
import 'package:shortcut_comics/widgets/rounded_button.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context); // To receive screen size
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.5,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/shortcut.png', width: mediaQuery.size.width * 0.5,),
                    ],
                  ),
                ),
              ),
              HomeButtonGroup(),
            ],
          ),
        ),
      ),
    );
  }
}
