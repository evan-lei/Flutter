import 'package:flutter/material.dart';
import 'package:flutter_app_2/global_config.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_app_2/model/toutiao.dart';
import 'package:flutter_app_2/net/recommend_net.dart';

class Recommend extends StatefulWidget {
  @override
  _RecommendState createState() => new _RecommendState();
}

class _RecommendState extends State<Recommend> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive=>true;

  ScrollController _scrollController = new ScrollController();
  List<ToutiaoModel> _dataArray;
  List<String> apiTypeList = ['shehui','guonei','guoji','yule','tiyu','junshi','keji','caijing','shishang'];
  int index = 0;
  bool isLoadingMore = false;

  @override
  void initState(){
    super.initState();
    _fresh();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _more();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: RefreshIndicator(
        onRefresh: _fresh,
        child: new ListView.builder(
          itemCount: (_dataArray == null)?0:(_dataArray.length + 1),
          itemBuilder: (context, index)
          {
            if (_dataArray == null) {
              return new Container();
            }

            if (index == _dataArray.length) {
              return _buildLoadText();
            }

            return GestureDetector(
              child: _buildRow(_dataArray[index]),
              onTap: (){

              },
            );
          },
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget _buildRow(ToutiaoModel model){
    if (model == null) {
      return new Container(
        height: 0,
      );
    }

    Widget imageWidget;
    if(model.thumbnail_pic_s != null) {
      imageWidget = new Container(
        foregroundDecoration: new BoxDecoration(
          image: new DecorationImage(
            image:new NetworkImage(model.thumbnail_pic_s),
            fit:BoxFit.fill,
          ),
          borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
        ),
        height: 220,
      );
    }
    else {
      imageWidget = new Container(
        height: 0,
      );
    }


    return new Container(
      color: GlobalConfig.cardBackgroundColor,
      padding: const EdgeInsets.only(top: 10, left: 13, right: 13),

      child: new Column(
        children: <Widget>[
          new Container(
            child:new Text(model.category + " · " + model.author_name + " · " + model.date, style: new TextStyle(color: GlobalConfig.fontColor)),
            margin: const EdgeInsets.only(top: 0.0),
            alignment: Alignment.topLeft,
          ),

          new Container(
            child: new Text(
              model.title,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.2, color: GlobalConfig.dark == true? Colors.white70 : Colors.black),
            ),
            margin: new EdgeInsets.only(top: 6.0),
            alignment: Alignment.topLeft,
          ),

          new Container(
            child: imageWidget,
            margin: new EdgeInsets.only(top: (model.thumbnail_pic_s == null)?0.0:6.0),
            alignment: Alignment.topLeft,
          ),

          new Container(
            child: new Container(
              color: Colors.white30,
              height: 0.5,
              margin: new EdgeInsets.only(top: 13),
            ),
          )
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

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoadingMore ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<Null> _fresh() {
    return Future.delayed(Duration(seconds: 1),(){
      RecommendNet().getData(true, 'top').then((model){
        if (model != null) {
          if (_dataArray == null) _dataArray = List.generate(0, null);
          _dataArray.clear();
          _dataArray.addAll(model.data);
        }
        setState(() {});
      });
    });
//    return Future.delayed(Duration(seconds: 1),(){
//      if (_dataArray == null) _dataArray = List.generate(0, null);
//      _getData(true, 'top');
//    });
  }

  Future<Null> _more() {
    return Future<Null>((){
      if (index < (apiTypeList.length - 1)) {
        String type = apiTypeList[index];
        index++;
        RecommendNet().getData(false, type).then((model){
          if (model != null) {
            _dataArray.addAll(model.data);
          }
          setState(() {});
        });
      } else {
        setState(() {});
      }
    });

//    if (!isLoadingMore) {
//      setState(() {isLoadingMore = true;});
//      if (index < (apiTypeList.length - 1)) {
//        String type = apiTypeList[index];
//        index++;
//        _getData(false, type);
//      } else {
//        setState(() {isLoadingMore = false;});
//      }
//    }
  }

  Future<Null> _getData(bool isFresh, String type) async {
    var url = 'http://v.juhe.cn/toutiao/index?type='+type+'&key=aa4e398ed507e49248714b7ff097e93e';
    var httpClient = new HttpClient();

    if (isFresh) _dataArray.clear();

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var jsonString = await response.transform(Utf8Decoder()).join();
        var jsonResponse = json.decode(jsonString);
        var result = jsonResponse['result'];
        print(result);
        ToutiaoResponseModel responseModel = ToutiaoResponseModel.fromJson(result);
        setState(() {
          _dataArray.addAll(responseModel.data);
          isLoadingMore = false;
        });
      }
      else {
        print('response error');
      }
    }
    catch (exception) {
      print('exception');
    }

  }

}