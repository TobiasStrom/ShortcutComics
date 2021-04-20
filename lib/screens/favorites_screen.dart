import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/provides/database_provider.dart';
import 'package:shortcut_comics/widgets/favorites_item.dart';

class FavoritesScreen extends StatefulWidget {
  static final routeName = "/favorites";

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Future<List<Comics>> _comicsList;


  @override
  void initState() {
    super.initState();
    _comicsList = getComics();
  }
  Future<List<Comics>> getComics() async{
    final _comicsData = await DatabaseProvider.db.comics();
    return _comicsData;
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
            Container(
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.9,
              child: ListView.builder(
                itemCount: comicsData.favoritesComics.length,
                itemBuilder: (context, index) {
                  return FavoritesItem(key: Key('comics_$index'),comics: comicsData.favoritesComics[index]);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

/*
FutureBuilder<List<Comics>>(
              future: _comicsList,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return snapshot.data.length > 0 ?Container(
                    height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.9,
                    child: ListView.builder(
                      key: Key('favoritesList'),//for testing
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return FavoritesItem(key: Key('comics_$index'),comics: snapshot.data[index]);
                      },
                    ),
                  ): Text('You don\'t have any favorites');
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
 */
