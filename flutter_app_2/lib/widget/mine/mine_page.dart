import 'package:flutter/material.dart';
import 'package:flutter_app_2/global_config.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => new _MinePageState();
}

class _MinePageState extends State<MinePage>{
  @override
  List<String> dataList = ['个人中心','消息','设置','关于'];
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
              child: _buildListView(),
          ),
        ),
        theme: GlobalConfig.themeData
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, i){
        return _buildRow(i);
      },
    );
  }

  Widget _buildRow(int index) {
    String str = dataList[index];
    double height = (index==0?80:60);
    return new Container(
      color: GlobalConfig.themeData.canvasColor,
      child: new Column(
        children: <Widget>[
          new Container(
            height:height,
            child: new Text(
              str,
              style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0, color: GlobalConfig.dark == true? Colors.white : Colors.black),
            ),
            margin: const EdgeInsets.only(left:13),
            alignment: Alignment.centerLeft,
          ),

          new Container(
            child: new Container(
              color: Colors.black12,
              height: 7.0,
            ),
          )
        ],
      ),
    );
  }
}

