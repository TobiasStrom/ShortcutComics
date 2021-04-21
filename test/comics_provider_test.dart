import 'package:flutter_test/flutter_test.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';

void main() {

  final _comicsProvider = ComicsProvider();

  /// Fetch first comics
  /// Want to se if [fetchComics(0)] return
  /// first comics title
  test('fetch first comics', () async {
    Comics comics = await _comicsProvider.fetchComics(1);
    expect(comics.title, 'Barrel - Part 1');
  });

  /// Fetch comic with to low id
  /// Want to se if [fetchComics(-123)]
  /// That have a value below 0 return the correct comic
  test('fetch comic with to low id', () async {
    final comicsProvider = ComicsProvider();
    Comics comics = await comicsProvider.fetchComics(-123);
    expect(comics.title, 'Something went wrong');
  });

  /// Fetch comic with to hig id
  /// Want to se if [fetchComics(10000)]
  /// That have a value below over max return the correct comic
  test('fetch comics with to high id', () async {
    final comicsProvider = ComicsProvider();
    Comics comics = await comicsProvider.fetchComics(10000);
    expect(comics.title, 'Something went wrong');
  });

  /// Go to next comic
  /// If the [setSelectedComics] is the first comic
  /// then nextComics(true) should return the second comic;
  test('go to next comics',() async{
    _comicsProvider.setSelectedComics(new Comics(num: 1));
    Comics comics = await _comicsProvider.nextComics(true);
    expect(comics.title, 'Petit Trees (sketch)');
  });

  /// Go to prev comic
  /// If the [setSelectedComics] is the second comic
  /// then nextComics(true) should return the first comic;
  test('go to prev comics',() async{
    _comicsProvider.setSelectedComics(new Comics(num: 2));
    Comics comics = await _comicsProvider.nextComics(false);
    expect(comics.title, 'Barrel - Part 1');
  });

  /// Fetch first comicsId from text search
  /// it the user search for 'test'
  /// [fetchResponseFromTextToList] should return a list of ids
  test('fetch first comicsId from text search',() async{
    List<int> comics = await _comicsProvider.fetchResponseFromTextToList('test');
    expect(comics [0], 329);
  });

  /// Fetch first comics from text search
  /// it the user search for 'test'
  /// [fetchComicsByText] should return a list of comics
  test('fetch first comics from text search',() async {
    await _comicsProvider.fetchComicsByText('test');
    List<Comics> comics = _comicsProvider.searchComicsList;
    expect(comics[0].title, 'Turing Test');
  });

  /// Check if connected
  /// Want to check if the phone is connected to the internet.
  /// Computer must be online
  test('check if connected', () async {
    Future<bool> isOnline =  _comicsProvider.checkIfOnline();
    expect(isOnline, completion(true));
  });
}

