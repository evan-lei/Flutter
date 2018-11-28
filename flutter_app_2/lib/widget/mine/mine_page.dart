import 'package:flutter/material.dart';
import 'package:flutter_app_2/global_config.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => new _MinePageState();
}

class _MinePageState extends State<MinePage>{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('我的'),
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