import 'package:flutter/material.dart';
import 'package:flutter_app_2/global_config.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => new _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('发现'),
            actions: <Widget>[
              new Container(

              )
            ],
          ),
          body: new Center(
              child: null
          ),
        ),
        theme: GlobalConfig.themeData
    );
  }

}