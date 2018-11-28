import 'package:flutter/material.dart';
import 'package:flutter_app_2/global_config.dart';

class TagPage extends StatefulWidget {
  @override
  _TagPageState createState() => new _TagPageState();
}

class _TagPageState extends State<TagPage>{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('话题'),
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