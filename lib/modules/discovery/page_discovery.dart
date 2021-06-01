import 'package:english_teacher_app/controls/checkbox_formfield.dart';
import 'package:english_teacher_app/controls/reactive_date_field.dart';
import 'package:english_teacher_app/services/wechat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'ctr_discovery.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageDiscovery extends GetView<DiscoveryController> {
  var _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MyPage')),
        body: SafeArea(
            child: ReactiveForm(
          formGroup: this.controller.form,
          child: Column(
            children: [
              ReactiveTextField(
                  formControlName: "name",
                  decoration: InputDecoration(
                    labelText: '姓名',
                  )),
              ReactiveHaiserDateField(
                formControlName: "birthday",
                decoration: InputDecoration(
                  labelText: '出生日期',
                ),
              ),
              ReactiveDropdownField(
                  formControlName: "sex",
                  decoration: InputDecoration(
                    labelText: '性别',
                  ),
                  items: [
                    DropdownMenuItem(child: Text("男"), value: "male"),
                    DropdownMenuItem(child: Text("女"), value: "famale"),
                  ]),

              ReactiveTextField(
                  formControlName: "school",
                  decoration: InputDecoration(
                    labelText: '学校',
                  )),
              ReactiveDropdownField(
                  formControlName: "grade",
                  decoration: InputDecoration(
                    labelText: '年级',
                  ),
                  items: [
                    DropdownMenuItem(child: Text("七年级"), value: "7"),
                    DropdownMenuItem(child: Text("八年级"), value: "8"),
                    DropdownMenuItem(child: Text("九年级"), value: "9"),
                  ]),
              ReactiveFormConsumer(
                builder:
                    (BuildContext context, FormGroup formGroup, Widget child) {
                  return TextButton(onPressed: onSubmit, child: Text("ok"));
                },
              )
            ],
          ),
        )));
  }

  void onSubmit() {
    this.controller.goLogin();
  }
}
