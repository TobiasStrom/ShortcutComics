import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';

class ComicsItem extends StatelessWidget {
  final Comics comics;

  const ComicsItem(this.comics);

  @override
  Widget build(BuildContext context) {
    var comicsData = Provider.of<ComicsProvider>(context);
    bool isFavorites = comicsData.isComicsFavorites(comics.num);

    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, //Center everything on screen
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              comics.title,
              style: TextStyle(
                  fontSize: 25
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Image.network(
            comics.img,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description: ',
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
                    'If you like make favorite:',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                (isFavorites)?
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: (){
                    comicsData.toggleFavorites(comics);
                  },
                  iconSize: 50,
                ):
                IconButton(
                  icon: Icon(
                      Icons.favorite_border_outlined
                  ),
                  onPressed: (){
                    comicsData.toggleFavorites(comics);
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
                )
              ],
            ),
          ): Container(),
        ],
      ),
    );
  }
}
