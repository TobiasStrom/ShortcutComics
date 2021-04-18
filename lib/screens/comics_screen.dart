import 'package:flutter/material.dart';

class ComicsScreen extends StatelessWidget {
  static final routeName = '/comics';// For routing

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);// get media size

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: mediaQuery.size.width, //Make screen full size
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, //Center everything on screen
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 25
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container( //To simulate a image for designing
                  height: 300,
                  width: mediaQuery.size.width,
                  color: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Description: ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  'This is some description'
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'If you like make favorite:',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  iconSize: 50,
                  onPressed: () => null,
                ),
                Padding(
                  padding: const EdgeInsets.only(top :8.0),
                  child: Text(
                    'Published',
                    style: TextStyle(
                      fontSize: 18,

                    ),
                  ),
                ),
                Text(
                    '2020-04-20'
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
