import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:shortcut_comics/screens/search_result_screen.dart';

class SearchTextScreen extends StatefulWidget {
  static final routeName = '/search-text';

  @override
  _SearchTextScreenState createState() => _SearchTextScreenState();
}

class _SearchTextScreenState extends State<SearchTextScreen> {

  final _formKey = GlobalKey<FormState>();
  String _word;
  bool _searching = false;

  bool _checkInput(String text){
    RegExp regExp = new RegExp(r"^[a-zA-Z]+$");
    if(regExp.hasMatch(text)){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var comicsData = Provider.of<ComicsProvider>(context);

    _onSubmit() async {
      if(_formKey.currentState.validate()){
        setState(() {
          _searching = true;
        });
        await comicsData.fetchComicsByText(_word);
        Navigator.pushNamed(context, SearchResultScreen.routeName);
        setState(() {
          _searching = false;
        });
        }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (mediaQuery.size.height - mediaQuery.padding.top)* 0.4,
                child: Center(
                  child: Text(
                    'Search For a Comics',
                    style: TextStyle(
                        fontSize: 30
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              !_searching ? Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:70.0, right: 70, bottom: 20),
                      child: TextFormField (
                        onChanged: (value) => _word = value,
                        decoration: const InputDecoration(
                          hintText: 'Some word',
                        ),
                        validator: (text) {
                          if (!_checkInput(text) || text.isEmpty || text == null){
                            return 'Only one word and only letters';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value){
                          _word = value;
                          _onSubmit();
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        _onSubmit();
                      },
                      child: Text(
                          'Search'
                      ),
                    )
                  ],
                ),
              ): Column(
                children:[
                  CircularProgressIndicator(),
                  Text('Searching'),
                ]
              ),
            ],
          ),
        ),
      )
    );
  }
}

