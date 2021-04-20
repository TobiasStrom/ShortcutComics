import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/screens/comics_screen.dart';

class SearchResultItem extends StatelessWidget{
  final Comics comics;

  const SearchResultItem(this.comics);
  @override
  Widget build(BuildContext context) {
    var comicsData = Provider.of<ComicsProvider>(context);
    bool isFavorites = comicsData.isComicsFavorites(comics.num);
    return InkWell(
      onTap: (){
        comicsData.setSelectedComicsId(comics.num);
        comicsData.setSelectedComics(comics);
        Navigator.pushNamed(context, ComicsScreen.routeName);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                comics.title,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              Image.network(comics.img),
              Text(
                comics.num.toString(),
              ),
              Text(
                comics.alt,
                textAlign: TextAlign.center,
              ),
              Text(
                  comics.year+"-"+comics.month+"-"+comics.day
              ),
              (isFavorites)?
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
            ],
          ),
        ),
      ),
    );
  }
}
