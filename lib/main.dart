import 'package:flutter/material.dart';
import 'package:shortcut_comics/screens/comics_screen.dart';
import 'package:shortcut_comics/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortcut Comics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (ctx) => HomeScreen(),
        ComicsScreen.routeName : (ctx) => ComicsScreen(),
      },
    );
  }
}
