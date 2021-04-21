import 'package:flutter/material.dart';
import 'package:shortcut_comics/widgets/home_button_group.dart';
import 'package:shortcut_comics/widgets/home_landscape.dart';
import 'package:shortcut_comics/widgets/home_portrait.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context); // To receive screen size
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child:  mediaQuery.orientation ==
              Orientation.portrait ? HomePortrait():HomeLandscape(),
        ),
      ),
    );
  }
}
