import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageStatistics extends StatefulWidget {
  PageStatistics({Key key}) : super(key: key);

  @override
  _PageStatisticsState createState() => _PageStatisticsState();
}

class _PageStatisticsState extends State<PageStatistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("成长")  ),
       body:Center(child: Text("此功能正在制作中"))
    );
  }
}