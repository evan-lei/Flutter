import 'package:flutter/material.dart';
import 'package:flutter_app_2/global_config.dart';
import 'recommend.dart';
import 'follow.dart';
import 'package:flutter_app_2/temp.dart';
import 'hotRank.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  void initState(){
    super.initState();
  }

  Widget barSearch() {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new FlatButton.icon(
                onPressed: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) {
                      }
                  ));
                },
                icon: new Icon(
                    Icons.search,
                    color: GlobalConfig.fontColor,
                    size: 16.0
                ),
                label: new Text(
                  "宇宙最强搜索sogou",
                  style: new TextStyle(color: GlobalConfig.fontColor),
                ),
              ),
          ),

          new Container(
            decoration: new BoxDecoration(
              border: new BorderDirectional(
                start: new BorderSide(color: GlobalConfig.fontColor, width: 1.0),
              ),
            ),
          ),

          new Container(
            child: new FlatButton.icon(
                onPressed: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context){
                      }
                  ));
                },
                icon: new Icon(
                  Icons.border_color,
                  color: GlobalConfig.fontColor,
                  size: 14.0,
                ),
                label: new Text(
                  "热点",
                  style: new TextStyle(color: GlobalConfig.fontColor),
                ),
            ),

          ),
        ],
      ),

      decoration: new BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        color: GlobalConfig.searchBackgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: barSearch(),
            bottom: new TabBar(
                labelColor: GlobalConfig.dark == true ? new Color(0xFF63FDD9) : Colors.blue,
                unselectedLabelColor: GlobalConfig.dark == true ? Colors.white : Colors.black,
                tabs: [
                  new Tab(text:"关注"),
                  new Tab(text:"推荐"),
                  new Tab(text:"热榜"),
                ]
            ),
          ),
          body: new TabBarView(
              children: [
                new Follow(),
                new Recommend(),
                new HotRank()
              ],
          ),
        ),
    );
  }
}