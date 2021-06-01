import 'package:english_teacher_app/controls/cnx_card.dart';
import 'package:english_teacher_app/domain/route_arguments.dart';
import 'package:english_teacher_app/models/server_models.dart';
import 'package:english_teacher_app/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'practice_details_vm.dart';

class PagePracticeDetails extends StatefulWidget {
  @override
  _PagePraticeDetailsState createState() => _PagePraticeDetailsState();
}

class _PagePraticeDetailsState extends State<PagePracticeDetails> {
  @override
  Widget build(BuildContext context) {
    final ScreenPracticeDetailsArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(title: Text("练习分析")),
        body: Container(
          child: Column(
            children: <Widget>[
              renderGroupSummary(),
              Expanded(child: SingleChildScrollView(child: renderGroupWords()))
            ],
          ),
        ));
  }

  // 渲染- 练习概况
  Widget renderGroupSummary() {
    var txtStyle = const TextStyle(color: Colors.blue);
    return Text("aaa");

    /*
    return CnxCard(
        header: "练习概况",
        leading: Icon(Icons.access_alarm, size: 16, color: Colors.grey),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Table(columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2)
          }, children: [
            TableRow(children: [
              Text("练习时间"),
              Text("${formatDatetime(vm.practiceData.time)}", style: txtStyle),
              Text("练习时长"),
              Text("${vm.practiceData.mins}分钟", style: txtStyle)
            ]),
            TableRow(children: [
              Text("单词量"),
              Text("${vm.practiceData.wordCount}", style: txtStyle),
              Text("正确率"),
              Text(
                  "${NumberFormat("0.0").format(vm.practiceData.correctRate)}%",
                  style: txtStyle),
            ]),
          ]),
        ));
        */
  }

  //渲染 - 练习单词列表
  Widget renderGroupWords() {
    return Text("ok");
    /*
    return Consumer<VmPracticeDetails>(builder: (context, vm, child) {
      return CnxCard(
          header: "单词列表",
          leading: Icon(Icons.book, size: 16, color: Colors.grey),
          body: DataTable(
              headingRowHeight: 40,
              dataRowHeight: 35,
              horizontalMargin: 1,
              columns: <DataColumn>[
                DataColumn(label: Text("单词")),
                DataColumn(label: Text("中文")),
                DataColumn(label: Text("错误次数"))
              ],
              rows: vm.practiceData.words.map((e) => renderWord(e)).toList()));
    });
    */
  }

  //渲染-单词
  DataRow renderWord(WordPracticeSerModel word) {
    return DataRow(cells: [
      DataCell(Text(word.english)),
      DataCell(Text(word.chinese)),
      DataCell(Text(word.errorCount.toString())),
    ]);
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
