import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/screens/comics_screen.dart';
import 'package:shortcut_comics/widgets/favorites_item.dart';
import 'package:shortcut_comics/widgets/navigator_bar.dart';
import 'package:shortcut_comics/widgets/rounded_button.dart';

class FavoritesScreen extends StatefulWidget {
  static final routeName = "/favorites";

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var comicsData = Provider.of<ComicsProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(child:
              Center(child:
                  NavigatorBar(text: 'Favorites', fontSize: 30,)
              ),
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.1,
            ),
            comicsData.favoritesComics.length > 0 ? Container(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.9,
              child: ListView.builder(
                itemCount: comicsData.favoritesComics.length,
                itemBuilder: (context, index) {
                  return FavoritesItem(key: Key('comics_$index'),comics: comicsData.favoritesComics[index]);
                },
              ),
            ): Column( // If you don't have any favorites
              children: [
                Text('You don\'t have any favorites'),
                RoundedButton(
                  key: Key('todaysComics'), //for testing
                  text:'Browse comics' ,
                  width: mediaQuery.size.width * 0.5,
                  height: 40,
                  deactivate: false,
                  onClick: () {
                    Navigator.pushNamed(context, ComicsScreen.routeName);//Navigate to today's comics
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

