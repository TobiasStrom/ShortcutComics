import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/widgets/comics_item.dart';

class ComicsScreen extends StatefulWidget {
  static final routeName = '/comics';
  @override
  _ComicsScreenState createState() => _ComicsScreenState();
}

class _ComicsScreenState extends State<ComicsScreen> {
  Future<Comics> futureComics;

  @override
  void initState() {
    super.initState();

    final comicsData = context.read<ComicsProvider>();
    futureComics = comicsData.fetchComics(2443);

  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);// get media size

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: mediaQuery.size.width, //Make screen full size
            child: FutureBuilder<Comics>(
              future: futureComics,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ComicsItem(snapshot.data);
                }
                return Container(
                  height: (mediaQuery.size.height - mediaQuery.padding.top),
                  child: Center(
                      child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
