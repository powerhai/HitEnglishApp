import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PagePracticeComplate extends StatefulWidget {
  PagePracticeComplate({Key key}) : super(key: key);

  @override
  _PagePracticeComplateState createState() => _PagePracticeComplateState();
}

class _PagePracticeComplateState extends State<PagePracticeComplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("训练完成")
      ),
       body: wgContainer(),
    );
  }

Widget wgContainer(){
  return Container(
    padding: EdgeInsets.all(10),
    
    child: wgCongratulation(),
  );
}
  Widget wgCongratulation(){

    return Container(
      decoration: BoxDecoration( border:   Border.all(width: 1.0,  ) , color: Colors.lightGreen[100]),
      padding: EdgeInsets.all(20),
      child: Text("恭喜完成本次练习！")
    );
  }
}