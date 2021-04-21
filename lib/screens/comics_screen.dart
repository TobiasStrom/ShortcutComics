import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/widgets/comics_item.dart';
import 'package:shortcut_comics/widgets/rounded_button.dart';

class ComicsScreen extends StatefulWidget {
  static final routeName = '/comics';
  @override
  _ComicsScreenState createState() => _ComicsScreenState();
}

class _ComicsScreenState extends State<ComicsScreen> {
  Future<Comics> _futureComics;

  @override
  void initState() {
    super.initState();
    final comicsData = context.read<ComicsProvider>();
    //check if [selectedComicsId] is not null. It it is not null means that
    // the user have searched for a comics and want one specific comic.
    // Else get get the last one
    if(comicsData.selectedComicId != null){
      _futureComics = comicsData.fetchComics(comicsData.selectedComicId);
      comicsData.setSelectedComicsId(null);
    }
    else{
      _futureComics = comicsData.fetchComics(-1);
    }
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);// get media size
    var comicsData = Provider.of<ComicsProvider>(context); // get info from providers

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder<Comics>(
            future: _futureComics,
            builder: (context, comic) {
              if(comic.hasData){ // Check if comics have data.
                return Column(
                  children: [
                    Container(
                      height: (mediaQuery.size.height - mediaQuery.padding.top)* 0.9,
                      child: SingleChildScrollView(child: ComicsItem(comic.data)),
                    ),
                    Container(
                      height: (mediaQuery.size.height - mediaQuery.padding.top)* 0.1,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedButton(
                              text: 'Previous',
                              width: mediaQuery.size.width * 0.3,
                              height: 35,
                              deactivate: comicsData.selectedComics.num != -2 ? false: true,
                              color: Colors.red,
                              onClick: (){
                                _futureComics = comicsData.nextComics(false);// go to previous comics
                              },
                            ),
                            comicsData.selectedComics.num >0 ? Text(comicsData.selectedComics.num.toString()):Text(''),
                            RoundedButton(
                              text: 'Next',
                              width: mediaQuery.size.width * 0.3,
                              height: 35,
                              deactivate: comicsData.selectedComics.num != -3 ? false: true,
                              color: Colors.green,
                              onClick: (){
                                _futureComics = comicsData.nextComics(true); //go to next comics
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container(// if it don't
                height: (mediaQuery.size.height - mediaQuery.padding.top),
                child: Center(
                  child: Container(
                    height: 300,
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Check if you have internet connection')
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
