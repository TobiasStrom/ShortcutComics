import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shortcut_comics/widgets/comics_item.dart';
import '../models/comics.dart';

class ComicsProvider with ChangeNotifier{

  Comics _selectedComics;

  Comics get selectedComics => _selectedComics;

  //Method of returning comics from api
  Future<Comics> fetchComics(int num) async{
    Comics comics;
    String url ='https://xkcd.com/'+num.toString()+'/info.0.json'; // url for searching
    if(num == -1){ // if num is -1 get last comics
      url = 'https://xkcd.com/info.0.json'; // url for last comics
    }
    final response = await http.get(Uri.parse(url)); //make the http get request
    if(response.statusCode == HttpStatus.ok){//check if status code is ok;
      comics = Comics.fromJson(jsonDecode(response.body)); // convert response to Comics object
      _selectedComics = comics;
      notifyListeners();
      return comics;
    }else{ //if something did't go as planed return a default error comics
      comics = new Comics(
        num: -4, title: 'Something went wrong',
        safeTitle : 'Please try again',
        alt : 'You just have to wait',
        img :'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Sad_face.svg/603px-Sad_face.svg.png',
        link:'',
        news :'',
        transcript :'',
      );
      _selectedComics = comics;
      notifyListeners();
      return comics;
    }
  }

  Future<Comics> nextComics(){
    print('Next: ${_selectedComics.num}');
    return fetchComics(_selectedComics.num + 1);
  }

  Future<Comics> previousComics(){
    print('Prev: ${_selectedComics.num}');
    return fetchComics(_selectedComics.num - 1);
  }

  //Make it easy to remember what values means
  int _first = -2;
  int _last = -3;
}