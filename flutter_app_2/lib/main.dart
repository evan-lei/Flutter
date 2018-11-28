import 'package:flutter/material.dart';
import 'widget/index/index.dart';
import 'dart:ui';
import 'package:flutter_app_2/widget/mine/mine_page.dart';
import 'package:flutter_app_2/widget/video/video_page.dart';
import 'package:flutter_app_2/widget/native_flutter.dart';

void main() => runApp(_widgetForRoute(window.defaultRouteName));
//void main() => runApp(_widgetForRoute('Native'));

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'Mine':
      return MinePage();
    case 'Video':
      return VideoPage();
    case 'Native':
      return Native();
    default:
      return new AppDelegate();
  }
}

class AppDelegate extends StatelessWidget {
  Widget build(BuildContext context){
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter 知乎',
      home: new Index(),
    );
  }
}