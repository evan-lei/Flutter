import 'package:flutter/material.dart';
import 'package:flutter_app_2/global_config.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => new _VideoPageState();
}

class _VideoPageState extends State<VideoPage>{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('视频'),
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