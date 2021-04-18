import 'package:flutter/material.dart';
import 'package:shortcut_comics/screens/comics_screen.dart';
import 'package:shortcut_comics/screens/favorites_screen.dart';
import 'package:shortcut_comics/screens/search_screen.dart';
import 'package:shortcut_comics/screens/search_text_screen.dart';
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
                  child: Text(
                    'The best comics online',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
              RoundedButton(
                text:'Show today\'s comics' ,
                width: mediaQuery.size.width * 0.8,
                height: 40,
                onClick: () {
                  Navigator.pushNamed(context, ComicsScreen.routeName);//Navigate to today's comics
                },
              ),
              RoundedButton(
                text:'Search for comics by id' ,
                width: mediaQuery.size.width * 0.8,
                height: 35,
                onClick: (){
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
              ),
              RoundedButton(
                text:'Search for comics by text',
                width: mediaQuery.size.width * 0.8,
                height: 35,
                onClick: (){
                  Navigator.pushNamed(context, SearchTextScreen.routeName);
                },
              ),
              RoundedButton(
                text: 'Show Favorites',
                width: mediaQuery.size.width * 0.8,
                height: 35,
                onClick: () {
                  Navigator.pushNamed(context, FavoritesScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
