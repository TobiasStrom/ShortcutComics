import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/screens/comics_screen.dart';
import 'package:shortcut_comics/widgets/rounded_button.dart';

class SearchScreen extends StatefulWidget {
  static final routeName = '/search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  Future<Comics> _futureLastComics;
  String _stringFromForm;
  int _searchNumber;

  @override
  void initState() {
    super.initState();
    final comicsData = context.read<ComicsProvider>();
    _futureLastComics = comicsData.fetchComics(-1);
  }

  bool _checkInput(String num, int max){
    try {
      _searchNumber = int.parse(num);
      if(_searchNumber <= max && _searchNumber >= 1){
        return true;
      }
    }
    on FormatException{
      print('Wrong Format');
      _searchNumber = -1;
    }
    return false;
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var comicsData = Provider.of<ComicsProvider>(context);

    void _onSubmit(){
      if(_formKey.currentState.validate()){
        _formKey.currentState.save();
        comicsData.setSelectedComicsId(_searchNumber);
        Navigator.pushNamed(context, ComicsScreen.routeName);
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: _futureLastComics,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Column(
                  children: [
                    Container(
                      height: (mediaQuery.size.height - mediaQuery.padding.top)* 0.4,
                      child: Center(
                        child: Text(
                          'Search For a Comics \b between 1-${snapshot.data.num}',
                          style: TextStyle(
                              fontSize: 30
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:70.0, right: 70, bottom: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) => _stringFromForm = value,
                              decoration: const InputDecoration(
                                hintText: 'Comics ID',
                              ),
                              validator: (text) {
                                if (!_checkInput(text, snapshot.data.num) || text.isEmpty || text == null){
                                  return 'Only number and between 1 and ${snapshot.data.num}';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value){
                                _stringFromForm = value;
                                _onSubmit();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    RoundedButton(
                      height: 35,
                      width: 100,
                      text: 'Search',
                      onClick: (){
                        _onSubmit();
                      },
                    )
                  ],
                );
              }else if(snapshot.hasError){
                return Text(snapshot.error); // print error
              }
              return Container( // Show spinner when waiting for data
                height: (mediaQuery.size.height - mediaQuery.padding.top),
                child: Center(
                    child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}

