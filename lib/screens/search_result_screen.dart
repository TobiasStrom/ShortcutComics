import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/widgets/search_result_item.dart';

class SearchResultScreen extends StatefulWidget {
  static final routeName = '/search-result';
  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    var comicsData = Provider.of<ComicsProvider>(context);

    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (mediaQuery.size.height - mediaQuery.padding.top)* 0.1,
                child: Center(
                  child: Text(
                      'Results',
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                ),
              ),
              Container(
                height: (mediaQuery.size.height - mediaQuery.padding.top)* 0.9,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return SearchResultItem(comicsData.searchComicsList[index]);
                    //return Text(comicsList[index].toString());
                  },
                  itemCount: comicsData.searchComicsList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
