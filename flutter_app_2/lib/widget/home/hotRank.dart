import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_app_2/model/article.dart';
import 'package:flutter_app_2/global_config.dart';

class HotRank extends StatefulWidget {
  _HotRankState createState() => new _HotRankState();
}

class _HotRankState extends State<HotRank> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive=>true;

  List<Article> _dataArray;
  ScrollController _scrollController = new ScrollController();

  void initState(){
    super.initState();
    _fresh();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _more();
      }
    });
  }

  Widget build(BuildContext context) {
    return new Container(
      child: RefreshIndicator(
        onRefresh: _fresh,
        child: new ListView.builder(
          itemCount: (_dataArray == null)?0:(_dataArray.length+1),
          itemBuilder: (context, index){
            if (_dataArray == null) {
              return new Container();
            }

            if (index == _dataArray.length) {
              return _buildLoadText();
            }

            return _buildRow(_dataArray[index]);
            },
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget _buildRow(Article article){
    return new Container(
      color: GlobalConfig.themeData.canvasColor,
      child: new Column(
        children: <Widget>[

          new Container(
            height:60,
            child: new Row(
              children: <Widget>[
                new Container(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(article.headUrl),
                    radius: 15.0,
                  ),
                ),

                new Column(
                  children: <Widget>[
                    new Container(
                      margin: const EdgeInsets.only(top:11),
                      child: new Text("  " + article.user, style: new TextStyle(fontSize: 16.0, color: GlobalConfig.fontColor)),
                    ),
                    new Text("  " + article.time, style: new TextStyle(fontSize: 12.0, color: GlobalConfig.fontColor)),
                  ],
                ),
              ],
            ),
            margin: const EdgeInsets.only(left:13),
            alignment: Alignment.centerLeft,
          ),

          new Container(
            child: new Container(
              color: Colors.black12,
              height: 5.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadText() {
    return Container(
      child:  Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Text("加载中……"),
        ),
      ), color: Colors.white70,);
  }

  Future<Null> _fresh() {
    return Future.delayed(Duration(seconds: 1),(){
      if (_dataArray == null) _dataArray = List.generate(0, null);
      _dataArray.clear();
      _dataArray.addAll(articleList);
      _dataArray.addAll(articleList);
      _dataArray.addAll(articleList);
      setState(() {});
    });
  }

  Future<Null> _more() {
    return Future.delayed(Duration(seconds: 1),(){
      _dataArray.addAll(articleList);
      setState(() {});
    });
  }
}