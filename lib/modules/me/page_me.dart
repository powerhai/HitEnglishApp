 
import 'package:english_teacher_app/controls/cnx_list_tile.dart';
import 'package:english_teacher_app/view_models/me_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';  
import 'controller_me.dart';

class PageMe extends GetView<MeController> {
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: Text("我"),
            ),
            body: Obx(() => this.controller.isLoggedIn.value == true
                ? buildLoggedInPanel()
                : buildNoLoggedInPanel())));
  }

  Widget buildNoLoggedInPanel() {
    return TextButton(
      child: Text("请先登录"),
      onPressed: () {
        this.controller.gotoLoginPage();
      },
    );
  }
 
  Widget buildLoggedInPanel() {
    return Column(
      children: <Widget>[
        buildPhoto(),
        Divider(height: 1, color: Colors.grey),
        InkWell(
          onTap: () {
            this.editUserName();
          },
          child: CnxListTile(
            title: Text("姓名"),
            trailing: Obx(() => Text(this.controller.name.value)),
          ),
        ),
        InkWell(
          onTap: () {
            this.selectSex();
          },
          child: CnxListTile(
            title: Text("性别"),
            trailing: Obx(() => Text(this.controller.sexString.value)),
          ),
        ),
        InkWell(
          onTap: () {
            this.editSchool();
          },
          child: CnxListTile(
            title: Text("学校"),
            trailing: Obx(() => Text(this.controller.school.value)),
          ),
        ),
        buildRowBirthday(),
        SizedBox(height: 20),
        Divider(height: 1, color: Colors.grey),
        buildRowPublisher(),
        buildRowGrade(),
      ],
    );
  }

  Widget buildPhoto() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
          child: ClipOval(
              child:
                  Image.asset("resources/rui.png", width: 120, height: 120))),
    );
  }

  //渲染 - 生日
  Widget buildRowBirthday() {
    return InkWell(
      onTap: () {
        selectBirthday();
      },
      child: Obx(() => CnxListTile(
            title: Text("出生日期"),
            trailing: Text(this.controller.birthday == null
                ? ""
                : DateFormat("yyyy-MM-dd")
                    .format(this.controller.birthday.value)),
          )),
    );
  }

  //渲染- 年级
  Widget buildRowGrade() {
    return InkWell(
      onTap: () {
        this.selectGrade();
      },
      child: CnxListTile(
        title: Text("年级"),
        trailing: Obx(() => Text(this.controller.gradeString.value)),
      ),
    );
  }

  //渲染-教材
  Widget buildRowPublisher() {
    return InkWell(
      onTap: () {
        this.selectPublisher();
      },
      child: CnxListTile(
        title: Text("教材"),
        trailing: Obx(() => Text(this.controller.publisherString.value)),
      ),
    );
  }

  selectPublisher() {
    Picker picker = new Picker(
        adapter: PickerDataAdapter<String>(
            data: this.controller.publishers.map((s) {
          return new PickerItem(text: Text(s.name), value: s.id);
        }).toList()),
        selecteds: [this.controller.publisherIndex],
        changeToFirst: true,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        looping: false,
        hideHeader: true,
        title: Text("教材"),
        onConfirm: (Picker picker, List value) {
          var item = value[0];
          this.controller.updatePublisher(item);
        });
    picker.showDialog(Get.context);
  }

  void selectBirthday() {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          customColumnType: [0, 1, 2],
          minValue: DateTime(1960),
          maxValue: DateTime.now(),
          value: this.controller.birthday.value,
          daySuffix: "日",
          isNumberMonth: true,
          monthSuffix: "月",
          yearSuffix: "年",
        ),
        title: Text("出生日期"),
        cancelText: "取消",
        confirmText: "确定",
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          this
              .controller
              .updateBirthday((picker.adapter as DateTimePickerAdapter).value);
        }).showDialog(Get.context);
  }

  void editUserName() {
    FocusNode focusNode = new FocusNode();
    TextEditingController controller =
        new TextEditingController(text: this.controller.name.value);
    Get.dialog(new AlertDialog(
      insetPadding: EdgeInsets.all(1),
      title: new Text("编辑姓名"),
      content: new TextField(
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(width: 0.3)),
          labelText: '姓名',
        ),
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Get.back();
          },
          child: new Text("取消"),
        ),
        new TextButton(
          onPressed: () {
            Get.back();
            this.controller.updateName(controller.text);
          },
          child: new Text("确认"),
        ),
      ],
    ));
  }

  void editSchool() {
    FocusNode focusNode = new FocusNode();
    TextEditingController ctr =
        new TextEditingController(text: this.controller.school.value);
    Get.dialog(new AlertDialog(
      insetPadding: EdgeInsets.all(1),
      title: new Text("编辑学校"),
      content: new TextField(
        focusNode: focusNode,
        controller: ctr,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(width: 0.3)),
          labelText: '学校',
        ),
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Get.back();
          },
          child: new Text("取消"),
        ),
        new TextButton(
          onPressed: () {
            Get.back();
            this.controller.updateSchool(ctr.text);
          },
          child: new Text("确认"),
        ),
      ],
    ));
  }

  void selectSex() {
    List<PickerItem<int>> list = [];
    this.controller.sexMap.forEach((s) {
      list.add(new PickerItem<int>(text: Text(s.name), value: s.id));
    });
    Picker picker = new Picker(
        title: Text("性别"),
        hideHeader: true,
        adapter: PickerDataAdapter<int>(data: list),
        selecteds: [this.controller.sex.value],
        changeToFirst: true,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        looping: false,
        onConfirm: (Picker picker, List value) {
          var sex = picker.getSelectedValues()[0];
          this.controller.updateSex(sex);
        });
    picker.showDialog(Get.context);
  }

  void selectGrade() {
    Picker picker = new Picker(
        title: Text("年级"),
        hideHeader: true,
        adapter: PickerDataAdapter<int>(
            data: this.controller.grades.map((s) {
          return new PickerItem(text: Text(s.name), value: s.id);
        }).toList()),
        selecteds: [this.controller.gradeIndex],
        changeToFirst: true,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        looping: false,
        onConfirm: (Picker picker, List value) {
          var grade = picker.getSelectedValues()[0];
          this.controller.updateGrade(grade);
        });
    picker.showDialog(Get.context);
  }
}

 