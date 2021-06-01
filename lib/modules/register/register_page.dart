import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('注册会员')),
        body: SafeArea(
            child: Obx(() => IndexedStack(
                  index: this.controller.pageIndex.value,
                  children: [buildFormA(), buildFormB()],
                ))));
  }

  Widget buildFormA() {
    return Form(
        child: Column(
      children: [
        Text("提交相片"),
        DropdownButtonFormField(
            items: [DropdownMenuItem(child: Text("ok"), value: "男")]),
        Container(
            height: 300,
            width: 200,
            child: Obx(() {
              if (this.controller.cameraIsReady.value == true)
                return CameraPreview(this.controller.cameraController);
              else
                return Text("Camera is loading...");
            })),
        Row(
          children: [
            TextButton(
              onPressed: () {
                this.controller.takePhoto();
              },
              child: Text('拍照'),
            )
          ],
        )
      ],
    ));
  }

  Widget buildFormB() {
    final GlobalKey key = GlobalKey<FormState>();
    return Form(
        key: key,
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => {},
              decoration: InputDecoration(labelText: '姓名'),
              enableSuggestions: true,
              maxLength: 20,
              style: TextStyle(fontSize: 20),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (value) => {},
                decoration: InputDecoration(labelText: '性别'),
                enableSuggestions: true,
                obscureText: true,
                maxLength: 20,
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Insira uma senha';
                  } else if (value.length < 5) {
                    return 'Insira uma senha maior';
                  } else
                    return null;
                }),
            TextButton(
              onPressed: () {
                final FormState form = key.currentState;
                form.validate() ? form.save() : print('erro ao logar');
              },
              child: Text('注册'),
            )
          ],
        ));
  }
}
