import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/screens/comics_screen.dart';
import 'package:shortcut_comics/screens/favorites_screen.dart';
import 'package:shortcut_comics/screens/search_screen.dart';
import 'package:shortcut_comics/screens/search_text_screen.dart';

import 'rounded_button.dart';

class HomeButtonGroup extends StatefulWidget {
  @override
  _HomeButtonGroupState createState() => _HomeButtonGroupState();
}

class _HomeButtonGroupState extends State<HomeButtonGroup> {
  Future<bool> _hasConnection;

  @override
  void initState() {
    super.initState();
    final comicsData = context.read<ComicsProvider>();
    setState(() {
      _hasConnection = comicsData.checkIfOnline();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var comicsData = Provider.of<ComicsProvider>(context);
    setState(() {
      _hasConnection = comicsData.checkIfOnline();
    });
    return FutureBuilder(
      future: _hasConnection,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return snapshot.data ? Column(
            children: [
              RoundedButton(
                key: Key('todaysComics'), //for testing
                text:'Show today\'s comics' ,
                width: mediaQuery.size.width * 0.8,
                height: 40,
                deactivate: false,
                onClick: () {
                  Navigator.pushNamed(context, ComicsScreen.routeName);//Navigate to today's comics
                },
              ),
              RoundedButton(
                text:'Search for comics by id' ,
                key: Key('searchId'), //for testing
                width: mediaQuery.size.width * 0.8,
                height: 35,
                deactivate: false,
                onClick: (){
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
              ),
              RoundedButton(
                text:'Search for comics by text',
                key: Key('searchText'), //for testing
                width: mediaQuery.size.width * 0.8,
                height: 35,
                deactivate: false,
                onClick: (){
                  Navigator.pushNamed(context, SearchTextScreen.routeName);
                },
              ),
              RoundedButton(
                key: Key('favorites'), //for testing
                text: 'Show Favorites',
                width: mediaQuery.size.width * 0.8,
                height: 35,
                deactivate: false,
                onClick: () {
                  Navigator.pushNamed(context, FavoritesScreen.routeName);
                },
              ),
            ],
            ): Column(
            children: [
              Text('You don\' have internet connection '),
              RoundedButton(
                text: 'Show Favorites',
                width: mediaQuery.size.width * 0.8,
                height: 35,
                deactivate: false,
                onClick: () {
                  Navigator.pushNamed(context, FavoritesScreen.routeName);
                },

              ),
            ],
          );
        }
        return CircularProgressIndicator();
    },);
  }
}

/*
Column(
      children: [
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
    )
 */
