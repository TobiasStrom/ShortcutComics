import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/comics.dart';

class ComicsProvider with ChangeNotifier{

  //Method of returning comics from api
  Future<Comics> fetchComics(int num) async{
    Comics comics;
    String url ='https://xkcd.com/'+num.toString()+'/info.0.json'; // url for searching
    final response = await http.get(Uri.parse(url)); //make the http get request
    if(response.statusCode == HttpStatus.ok){//check if status code is ok;
      comics = Comics.fromJson(jsonDecode(response.body)); // convert response to Comics object
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
      return comics;
    }
  }
}