import 'package:flutter/material.dart';
import 'package:flutter_app_2/global_config.dart';
import 'navigation_icon_view.dart';
import '../home/home_page.dart';
import '../video/video_page.dart';
import '../tag/tag_page.dart';
import '../find/find_page.dart';
import '../mine/mine_page.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => new _IndexState();
}

class _IndexState extends State<Index> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
  List<StatefulWidget> _pageList;
  StatefulWidget _currentPage;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: new Icon(Icons.assignment),
        title: new Text("推荐"),
        vsync: this,
      ),

      new NavigationIconView(
        icon: new Icon(Icons.all_inclusive),
        title: new Text("视频"),
        vsync: this,
      ),

      new NavigationIconView(
        icon: new Icon(Icons.add_shopping_cart),
        title: new Text("话题"),
        vsync: this,
      ),

      new NavigationIconView(
        icon: new Icon(Icons.add_alert),
        title: new Text("发现"),
        vsync: this,
      ),

      new NavigationIconView(
        icon: new Icon(Icons.perm_identity),
        title: new Text("我的"),
        vsync: this,
      ),
    ];

    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    _pageList = <StatefulWidget>[
      new HomePage(),
      new VideoPage(),
      new TagPage(),
      new FindPage(),
      new MinePage()
    ];

    _currentPage = _pageList[_currentIndex];
  }

  void _rebuild() {
    setState((){});
  }

  @override
  void dispose() {
    super.dispose();
    for (NavigationIconView view in _navigationViews) {
      view.controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
        items: _navigationViews
            .map((NavigationIconView navigationIconView) => navigationIconView.item)
            .toList(),
        currentIndex: _currentIndex,
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState((){
            _navigationViews[_currentIndex].controller.reverse();
            _currentIndex = index;
            _navigationViews[_currentIndex].controller.forward();
            _currentPage = _pageList[_currentIndex];
          });
        }
    );

    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          // 使用IndexedStack可以在tab切换的时候保持原有状态
          body: IndexedStack(
            index: _currentIndex,
            children: _pageList,
          ),
          bottomNavigationBar: bottomNavigationBar,
        ),
        theme: GlobalConfig.themeData
    );
  }
}