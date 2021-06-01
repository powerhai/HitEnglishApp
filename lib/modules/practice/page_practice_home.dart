 
import 'package:english_teacher_app/controls/cnx_list_tile.dart';
import 'package:english_teacher_app/domain/route_arguments.dart';
import 'package:english_teacher_app/models/server_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart'; 
import 'package:english_teacher_app/domain/page_names.dart';
import 'controller_pratice_home.dart';
import 'package:get/get.dart';

class PagePraticeHome extends GetView<ControllerPraticeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("练习"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
             child: Obx(()=> renderPraticeHistory()),
          ),
          renderPlayButton()
        ],
      ),
    );
  }

  //渲染-底部-开始练习
  Widget renderPlayButton() {
    return Container(
      padding: EdgeInsets.all(20),
      child: RaisedButton(
          color: Colors.blue[300],
          textColor: Colors.white,
          highlightColor: Colors.black38,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          onPressed: () {
            Get.offNamed("TypeWords");
          },
          child: Text("开始练习")),
    );
  }

  //渲染-练习历史 （含统计块）
  Widget renderPraticeHistory() {
    var col = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Obx(()=>renderSummary() )
        
      ],
    );
    var scrollView =
        CustomScrollView(physics: BouncingScrollPhysics(), slivers: <Widget>[]);
    for (var p in this.controller.pratices.value) {
      scrollView.slivers.add(SliverToBoxAdapter(child: renderPraticeRow(p)));
    }
    col.children.add(Expanded(child: scrollView));
    return col;
  }

  //渲染-顶部统计块
  Widget renderSummary() {
    if(controller.practiceSumData.value == null)
      return Text("Loading");
    else
        return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey[100]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Obx(() => RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "总时长：",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  TextSpan(
                    text: "${controller.practiceSumData.value.minutes}分钟",
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ]))),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "词汇量：",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              TextSpan(
                text: "${controller.practiceSumData.value.wordCount}",
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ])),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "次数：",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              TextSpan(
                text: "${controller.practiceSumData.value.practiceCount}",
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ])),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "正确率：",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              TextSpan(
                text:
                    "${NumberFormat("0.0").format(this.controller.practiceSumData.value.lastPracticeCorrectRate)}%",
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ]))
          ]),
    );
  }

  //渲染-练习历史行
  Widget renderPraticeRow(PracticeLightSerModel p) {
    return InkWell(
      onTap: () {
        Get.offNamed(PageNames.PracticeDetails,
            arguments: new ScreenPracticeDetailsArguments(p.id));
      },
      child: CnxListTile(
        padding: EdgeInsets.all(5),
        height: 50,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              formatDatetime(p.time),
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Expanded(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "正确率：",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                TextSpan(
                  text: "${NumberFormat("0.0").format(p.correctRate)}%  ",
                  style: TextStyle(color: Colors.green, fontSize: 13),
                ),
                TextSpan(
                  text: "时长：",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                TextSpan(
                  text: "${p.mins}  ",
                  style: TextStyle(color: Colors.green, fontSize: 13),
                ),
                TextSpan(
                  text: "单词量：",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                TextSpan(
                  text: "${p.wordCount}",
                  style: TextStyle(color: Colors.green, fontSize: 13),
                )
              ])),
            ),
          ],
        ),
        showBottomLine: true,
        trailing: Icon(Icons.navigate_next, size: 15),
      ),
    );
  }

  String formatDatetime(DateTime dt) {
    var duration = DateTime.now().difference(dt);
    switch (duration.inDays) {
      case 0:
        {
          return DateFormat("今天 HH:mm").format(dt);
        }
      case 1:
        {
          return DateFormat("昨天 HH:mm").format(dt);
        }
      case 2:
        {
          return DateFormat("前天 HH:mm").format(dt);
        }
    }
    return DateFormat("M月dd日 HH:mm").format(dt);
  }
}

 