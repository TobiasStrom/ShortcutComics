import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../models/comics.dart';

class ComicsProvider with ChangeNotifier{

  Comics _selectedComics;
  List<Comics> _favoritesComics = [];
  int _selectedComicsId;
  List<Comics> _searchComicsList = [];

  // get methods
  Comics get selectedComics => _selectedComics;
  List<Comics> get favoritesComics => _favoritesComics;
  List<Comics> get searchComicsList => _searchComicsList;
  int get selectedComicId => _selectedComicsId;

  // set methods
  void setSelectedComicsId(int value) {
    _selectedComicsId = value;
  }
  void setSelectedComics(Comics comics){
    _selectedComics = comics;
  }

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
    }
    else if (response.statusCode == HttpStatus.notFound){
      Comics comics = new Comics(
        num: selectedComics.num == 1 ? _first : _last, //set comics number for handling next and prev comics
        title: selectedComics.num == 1 ? 'That was the fist one': 'You have to wait for a new one',
        safeTitle : selectedComics.num == 1 ? 'That was the fist one': 'You have to wait for a new one',
        alt : selectedComics.num == 1 ? 'I se you like comics' : 'No more',
        img :'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Sad_face.svg/603px-Sad_face.svg.png', // default sad face image
      );
      _selectedComics = comics;
      notifyListeners();
      return comics;
    }else{ //if something did't go as planed return a default error comics
      comics = new Comics(
        num: -4,
        title: 'Something went wrong',
        safeTitle : 'Please try again',
        alt : 'You just have to wait',
        img :'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Sad_face.svg/603px-Sad_face.svg.png',
      );
      _selectedComics = comics;
      notifyListeners();
      return comics;
    }
  }

  // go through  to comics
  Future<Comics> nextComics(bool next){
    if(_selectedComics.num == _first){ // if selectedComics is the first one go to the first one
      return fetchComics(1);
    }
    if(_selectedComics.num == _last){// if selectedComics is the first one go to the last one
      return fetchComics(-1);
    }
    if(_selectedComics.num != null){
      if(next){ // if next is true go to next
        return fetchComics(_selectedComics.num + 1);
      }else{ // else go to prev
        return fetchComics(_selectedComics.num - 1);
      }
    }
    return fetchComics(-1);
  }

  Future<void> toggleFavorites(Comics comics) async {
    final existingIndex =
      _favoritesComics.indexWhere((element) => element.num == comics.num); // get comics index if it is favorites
    if(existingIndex >= 0) {
      _favoritesComics.removeAt(existingIndex); // remove if from the list if it exists
      try {
        if (await File(comics.imageData).exists()) { // check if image exists on device
          await File(comics.imageData).delete(); // delete if exists
        }
      } catch (_) {
        print('Image don\'t exist'); // print error
      }
    }else{
      var response = await http.get(Uri.parse(comics.img)); // get image so it can be saved on device
      Directory appDocDir = await getApplicationDocumentsDirectory(); // get app path on phone
      var imagesPath = appDocDir.path + "/images"; // set image path
      await Directory(imagesPath).create(recursive: true); // create directory if noe exist
      var filePathAndName = appDocDir.path + '/images/${comics.num}.png'; // set file and path name
      File image = new File(filePathAndName); // make new file from path
      image.writeAsBytesSync(response.bodyBytes); //write image to device
      comics.imageData = filePathAndName; // set filepath to imageData.
      _favoritesComics.add(comics); // add if not exits
    }
    notifyListeners();
  }
  // check if comics is favorites;
  bool isComicsFavorites(int id){
    return _favoritesComics.any((element) => element.num == id);
  }

  Future<List<int>> fetchResponseFromTextToList(String text) async {
    String url ='https://relevantxkcd.appspot.com/process?action=xkcd&query=$text';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200) {
      print(response);
      List<String> responseList = response.body.split("").toList();
      List<String> numbers = [];
      RegExp regExp = new RegExp(r"[0-9a-zA-Z ]+");

      for (int i = 0; i < responseList.length; i++) {
        if (regExp.hasMatch(responseList[i])) {
          numbers.add(responseList[i]);
        }
      }
      List<String> matches = numbers.join().split(" ").toList();
      List<int> lastList = [];

      for (var num in matches) {
        try {
          lastList.add(int.parse(num));
        } catch (_) {
          print('not string');
        }
      }
      lastList.removeAt(0);
      lastList.removeAt(0);

      return lastList;
    }
    else{
      return [];
    }

  }

  Future<List<Comics>> fetchComicsByText(String text) async {
    _searchComicsList = [];
    List<int> intComics;
    await fetchResponseFromTextToList(text).then((value) async {
      intComics = value;
      if(intComics.length != 0){
        List<Comics> resultList = [];
        for(var comicsNub in intComics){
          _searchComicsList.add(await fetchComics(comicsNub));
        }
        return resultList;
      }
    });
    return [];
  }

  //Make it easy to remember what values means
  int _first = -2;
  int _last = -3;
}