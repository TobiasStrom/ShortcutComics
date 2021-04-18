import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';

class FavoritesItem extends StatelessWidget {
  final Comics comics;

  const FavoritesItem(this.comics);

  @override
  Widget build(BuildContext context) {
    var comicsData = Provider.of<ComicsProvider>(context);
     return Card(
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
            Image.file(File(comics.imageData)),
            Text(
              'Index: ' + comics.num.toString(),
            ),
            Text(
              comics.alt,
              textAlign: TextAlign.center,
            ),
            Text(
                comics.year+"-"+comics.month+"-"+comics.day
            ),
            IconButton(icon: Icon(Icons.delete), onPressed: (){
              comicsData.toggleFavorites(comics);
            }),
          ],
        ),
      ),
    );
  }
}
