import 'package:flutter/material.dart';
import 'package:flutter_app_2/global_config.dart';
import 'package:flutter_app_2/model/article.dart';

class ArticleDetailPage extends StatefulWidget {
  Article article;
  ArticleDetailPage(this.article);

  @override
  _ArticleDetailState createState() => new _ArticleDetailState(article);
}

class _ArticleDetailState extends State<ArticleDetailPage>{
  Article article;
  _ArticleDetailState(this.article);
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('文章详情'),
          actions: <Widget>[
            new Container(

            ),
          ],
        ),
        body: new Center(
            child: _detailListView()
        ),
      ),
      onWillPop: null,
    );
  }

  Widget _detailListView () {
    return new ListView.builder(
      itemCount:10,
      itemBuilder: (context, i){
          if (i == 0) {
            return _detailRow();
          } else if (i == 1){
            return _sectionWidget();
          } else {
            return _answerWidget();
          }
        },
    );
  }

  Widget _detailRow (){
    Widget imageWidget;
    if(article.imgUrl != null) {
      imageWidget = new Container(
        foregroundDecoration: new BoxDecoration(
          image: new DecorationImage(
            image:new NetworkImage(article.imgUrl),
            fit:BoxFit.fill,
          ),
          borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
        ),
        height: 250,
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
            child: new Row(
              children: <Widget>[
                new Container(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(article.headUrl),
                    radius: 15.0,
                  ),
                ),
                new Text("  " + article.user + " " + article.action + " · " + article.time, style: new TextStyle(color: GlobalConfig.dark == true? Colors.white70 : Colors.black))
              ],
            ),
            margin: const EdgeInsets.only(top: 2.0),
          ),

          new Container(
            child: new Text(
              article.title,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.2, color: GlobalConfig.dark == true? Colors.white70 : Colors.black),
            ),
            margin: new EdgeInsets.only(top: 6.0),
            alignment: Alignment.topLeft,
          ),

          new Container(
            child: new Text(
              article.mark,
              style: new TextStyle(height: 1.1, fontSize: 14.0, color: GlobalConfig.dark == true? Colors.white70 : Colors.black),
            ),
            margin: new EdgeInsets.only(top: 6.0),
            alignment: Alignment.topLeft,
          ),

          new Container(
            child: imageWidget,
            margin: new EdgeInsets.only(top: (article.imgUrl == null)?0.0:6.0, bottom: 13.0),
            alignment: Alignment.topLeft,
          ),
        ],
      ),
    );
  }

  Widget _sectionWidget(){
    return new Container(
      height: 50,
      color: Colors.black54,
      padding: const EdgeInsets.only(top: 0, left: 13, right: 13),
      alignment: Alignment.centerLeft,
      child: new Text(
        "评论（8）",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: GlobalConfig.dark == true? Colors.white70 : Colors.black),
      ),
    );
  }

  Widget _answerWidget(){
    return new Container(
      color: Colors.black26,
      padding: const EdgeInsets.only(top: 10, left: 13, right: 13, bottom: 0),
      alignment: Alignment.centerLeft,
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Row(
              children: <Widget>[
                new Container(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(article.headUrl),
                    radius: 15.0,
                  ),
                ),
                new Text("  " + article.user + " " + article.action + " · " + article.time, style: new TextStyle(color: GlobalConfig.dark == true? Colors.white70 : Colors.black))
              ],
            ),
            margin: const EdgeInsets.only(top: 0.0),
          ),

          new Container(
            child: new Text(
              "中国最领先的中文搜索引擎,支持微信公众号、文章搜索,通过独有的SogouRank技术及人工智能算法为您提供最快、最准、最全的搜索服务。",
              style: new TextStyle(fontSize: 14.0, color: GlobalConfig.dark == true? Colors.white70 : Colors.black),
            ),
            margin: new EdgeInsets.only(top: 6, left: 0),
          ),

          new Container(
              child: new Container(
                color: Colors.white24,
                height: 0.5,
                margin: new EdgeInsets.only(top: 10),
              )
          ),
        ],
      ),
    );
  }
}
