import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/provides/database_provider.dart';
import 'package:shortcut_comics/screens/comics_screen.dart';
import 'package:shortcut_comics/screens/favorites_screen.dart';
import 'package:shortcut_comics/screens/home_screen.dart';
import 'package:shortcut_comics/screens/search_result_screen.dart';
import 'package:shortcut_comics/screens/search_screen.dart';
import 'package:shortcut_comics/screens/search_text_screen.dart';

void main() async {
  runApp(MyApp());
  DatabaseProvider.db.initDB();

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (ctx) => ComicsProvider()),
        //ChangeNotifierProvider(create: (ctx) => DatabaseProvider()),
      ],
      child: MaterialApp(
        title: 'Shortcut Comics',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (ctx) => HomeScreen(),
          ComicsScreen.routeName : (ctx) => ComicsScreen(),
          FavoritesScreen.routeName : (ctx) => FavoritesScreen(),
          SearchScreen.routeName : (ctx) => SearchScreen(),
          SearchTextScreen.routeName: (ctx) => SearchTextScreen(),
          SearchResultScreen.routeName: (ctx) => SearchResultScreen(),
        },
      ),
    );
  }
}