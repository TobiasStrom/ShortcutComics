
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/screens/search_screen.dart';

void main() {
  final _comicsProvider = ComicsProvider();
  test('check if connected', () async {
    final comicsProvider = ComicsProvider();
    Future<bool> isOnline =  comicsProvider.checkIfOnline();
    expect(isOnline, completion(true));
  });

  test('fetch first comics', () async {
    Comics comics = await _comicsProvider.fetchComics(1);
    expect(comics.title, 'Barrel - Part 1');
  });

  test('fetch comics with to low id', () async {
    final comicsProvider = ComicsProvider();
    Comics comics = await comicsProvider.fetchComics(-123);
    expect(comics.title, 'Something went wrong');
  });
  test('fetch comics with to high id', () async {
    final comicsProvider = ComicsProvider();
    Comics comics = await comicsProvider.fetchComics(10000);
    expect(comics.title, 'Something went wrong');
  });
  test('go to next comics',() async{
    _comicsProvider.setSelectedComics(new Comics(num: 1));
    Comics comics = await _comicsProvider.nextComics(true);
    expect(comics.title, 'Petit Trees (sketch)');
  });
  test('go to prev comics',() async{
    _comicsProvider.setSelectedComics(new Comics(num: 2));
    Comics comics = await _comicsProvider.nextComics(false);
    expect(comics.title, 'Barrel - Part 1');
  });
  test('fetch first comics num from text search',() async{
    List<int> comics = await _comicsProvider.fetchResponseFromTextToList('test');
    expect(comics [0], 329);
  });
  test('fetch first comics from text search',() async {
    await _comicsProvider.fetchComicsByText('test');
    List<Comics> comics = _comicsProvider.searchComicsList;
    expect(comics[0].title, 'Turing Test');
  });

  test('add to favorites',() async{
    final comicsProvider = ComicsProvider();
    Comics comics = await comicsProvider.fetchComics(1);
    await comicsProvider.toggleFavorites(comics);
    expect(comicsProvider.favoritesComics.length, 1);
  });
  test('remove from favorites',() async{
    final comicsProvider = ComicsProvider();
    Comics comics = await comicsProvider.fetchComics(1);
    await comicsProvider.toggleFavorites(comics);
    await comicsProvider.toggleFavorites(comics);
    expect(comicsProvider.favoritesComics.length, 0);
  });
}

