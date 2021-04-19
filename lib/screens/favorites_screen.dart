import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/widgets/favorites_item.dart';

class FavoritesScreen extends StatelessWidget {
  static final routeName = "/favorites";
  @override
  Widget build(BuildContext context) {
    var comicsData = Provider.of<ComicsProvider>(context);
    List<Comics> favorites = comicsData.favoritesComics;
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(child:
              Center(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back), onPressed: ()=> Navigator.pop(context)),
                    Text(
                      'Favorites',
                      style: TextStyle(
                          fontSize: 30
                      ),
                    ),
                    IconButton(icon: Icon(Icons.home), onPressed: ()=> Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false)),
                  ],
                ),
              ),
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.1,
            ),
            favorites.length > 0 ?Container(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.9,
              child: ListView.builder(
                key: Key('favoritesList'),//for testing
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return FavoritesItem(key: Key('comics_$index'),comics: favorites[index]);
                },
              ),
            ): Text('You don\'t have any favorites'),
          ],
        ),
      ),
    );
  }
}
