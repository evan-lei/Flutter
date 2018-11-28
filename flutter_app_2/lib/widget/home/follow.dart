import 'package:flutter/material.dart';
import 'package:flutter_app_2/global_config.dart';
import 'package:flutter_app_2/model/article.dart';
import 'article_detail_page.dart';

class Follow extends StatefulWidget {

  @override
  _FollowState createState() => new _FollowState();

}

// 继承AutomaticKeepAliveClientMixin可以在tab切换时保持原有状态
class _FollowState extends State<Follow>  with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive=>true;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder (
        itemBuilder: (context, i){
          final index = i % 4;
          return GestureDetector(
            child: _buildRow(articleList[index]),
            onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new ArticleDetailPage(articleList[index]))
              );
            },
          );
        }
    );
  }

  Widget _buildRow(Article article) {

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
        height: 200,
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
                new Text("  " + article.user + " " + article.action + " · " + article.time, style: new TextStyle(color: GlobalConfig.fontColor))
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

//          new Container(
//            child: new Text(
//              article.mark,
//              style: new TextStyle(height: 1.0, color: GlobalConfig.fontColor),
//            ),
//            margin: new EdgeInsets.only(top: 6.0),
//            alignment: Alignment.topLeft,
//          ),

          new Container(
            child: imageWidget,
            margin: new EdgeInsets.only(top: (article.imgUrl == null)?0.0:6.0),
            alignment: Alignment.topLeft,
          ),

          new Container(
            child: new Container(
              color: Colors.black26,
              height: 0.5,
              margin: new EdgeInsets.only(top: 8),
            ),
          )
        ],
      ),

    );
  }

}