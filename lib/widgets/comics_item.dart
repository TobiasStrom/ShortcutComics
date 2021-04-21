import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/provides/database_provider.dart';

class ComicsItem extends StatelessWidget {
  final Comics comics;
  const ComicsItem(this.comics);

  Future<int> isFavorite(BuildContext context) async {
    return DatabaseProvider.db.checkIfExists(comics.num);
  }

  @override
  Widget build(BuildContext context) {
    var comicsData = Provider.of<ComicsProvider>(context);
    bool isFavorites = comicsData.isComicsFavoritesList(comics.num);

    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, //Center everything on screen
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: Icon(Icons.arrow_back), onPressed: ()=> Navigator.pop(context)),
                Flexible(
                  child: Text(
                    comics.title,
                    key: Key('title'), // for testing
                    style: TextStyle(
                        fontSize: 25
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(key :Key('homeIcon'), icon: Icon(Icons.home), onPressed: ()=> Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false)),
              ],
            ),
          ),
          InteractiveViewer(
            child: Image.network(
              comics.img,
            ),
            minScale: 0.5,
            maxScale: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
              comics.alt
          ),
          comics.num > 0 ?Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'If you like it make favorite',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                isFavorites?
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: (){
                    comicsData.removeFromFavorites(comics);
                  },
                  iconSize: 50,
                ):
                IconButton(
                  icon: Icon(
                      Icons.favorite_border_outlined
                  ),
                  onPressed: (){
                    comicsData.addToFavorites(comics);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top :8.0),
                  child: Text(
                    'Published',
                    style: TextStyle(
                      fontSize: 18,

                    ),
                  ),
                ),
                Text(
                    comics.year+ " - " + comics.month + " - " + comics.day
                ),
                
              ],
            ),
          ): Container(),
        ],
      ),
    );
  }
}
