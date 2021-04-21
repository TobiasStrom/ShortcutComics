import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/provides/database_provider.dart';
import 'package:shortcut_comics/screens/comics_screen.dart';
import 'package:shortcut_comics/screens/favorites_screen.dart';
import 'package:shortcut_comics/screens/search_screen.dart';
import 'package:shortcut_comics/screens/search_text_screen.dart';

import 'rounded_button.dart';

class HomeButtonGroup extends StatefulWidget {
  final double width;

  const HomeButtonGroup(this.width);

  @override
  _HomeButtonGroupState createState() => _HomeButtonGroupState();
}

class _HomeButtonGroupState extends State<HomeButtonGroup> {
  Future<bool> _hasConnection;



  @override
  void initState()  {
    super.initState();
    final comicsData = context.read<ComicsProvider>();
    comicsData.setFavoritesList([]); // set the value to empty before it get data from sqlite
    DatabaseProvider.db.comics().then((list) => comicsData.setFavoritesList(list));
    setState(() {
      _hasConnection = comicsData.checkIfOnline();
    });
  }


  void _checkConnection(){
    final comicsData = context.read<ComicsProvider>();
    setState(() {
      _hasConnection = comicsData.checkIfOnline();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var comicsData = Provider.of<ComicsProvider>(context);
    setState(() {
      _hasConnection = comicsData.checkIfOnline();
    });
    return FutureBuilder(
      future: _hasConnection,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return snapshot.data ? Column(
            children: [
              RoundedButton(
                key: Key('todaysComics'), //for testing
                text:'Show today\'s comics' ,
                width: mediaQuery.size.width * widget.width,
                height: 40,
                deactivate: false,
                onClick: () {
                  Navigator.pushNamed(context, ComicsScreen.routeName);//Navigate to today's comics
                },
              ),
              RoundedButton(
                text:'Search for comics by id' ,
                key: Key('searchId'), //for testing
                width: mediaQuery.size.width * widget.width,
                height: 35,
                deactivate: false,
                onClick: (){
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
              ),
              RoundedButton(
                text:'Search for comics by text',
                key: Key('searchText'), //for testing
                width: mediaQuery.size.width * widget.width,
                height: 35,
                deactivate: false,
                onClick: (){
                  Navigator.pushNamed(context, SearchTextScreen.routeName);
                },
              ),
              RoundedButton(
                key: Key('favorites'), //for testing
                text: 'Show Favorites',
                width: mediaQuery.size.width * widget.width,
                height: 35,
                deactivate: false,
                onClick: () {
                  Navigator.pushNamed(context, FavoritesScreen.routeName);
                },
              ),
            ],
            ): Column(
            children: [
              Text('You don\' have internet connection '),
              RoundedButton(
                text: 'Show Favorites',
                width: mediaQuery.size.width * widget.width,
                height: 35,
                deactivate: false,
                onClick: () {
                  Navigator.pushNamed(context, FavoritesScreen.routeName);
                },
              ),
              IconButton(icon: Icon(Icons.refresh), onPressed: () => _checkConnection())
            ],
          );
        }
        return CircularProgressIndicator();
    },);
  }
}
