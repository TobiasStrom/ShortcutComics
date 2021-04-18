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
    _futureComics = comicsData.fetchComics(23);
    print('Init');
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);// get media size
    var comicsData = Provider.of<ComicsProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: mediaQuery.size.width, //Make screen full size
            child: FutureBuilder<Comics>(
              future: _futureComics,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Column(children: [
                    Container(
                      height: (mediaQuery.size.height - mediaQuery.padding.top)* 0.9,
                      child: SingleChildScrollView(child: ComicsItem(snapshot.data)),
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
                              color: Colors.red,
                              onClick: (){
                                _futureComics = comicsData.previousComics();
                              },
                            ),
                            RoundedButton(
                              text: 'Next',
                              width: mediaQuery.size.width * 0.3,
                              height: 35,
                              color: Colors.green,
                              onClick: (){
                                //comicsData.selectedComicId > comicsData.lastId ? null :
                                _futureComics = comicsData.nextComics();
                              },
                            ),

                          ],
                        ),
                      ),
                    ),
                    
                  ],);
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