import 'package:english_teacher_app/controls/lazy_index.dart';
import 'package:english_teacher_app/domain/statistics/page_statistics.dart';
import 'package:english_teacher_app/modules/discovery/page_discovery.dart';
import 'package:english_teacher_app/modules/home/controller_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../me/page_me.dart';
import '../practice/page_practice_home.dart'; 
import 'package:get/get.dart';

class PageHome extends GetView<HomeController> {
  List<String> _titles = ["发现2", "练习", "商店", "成长", "我"];
  List<Widget> _pages = [
    PageDiscovery(),
    PagePraticeHome(),
    PageStatistics(),
    PageMe(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Obx(() => LazyIndexedStack(
                  reuse: false,
                  itemCount: _pages.length,
                  index: this.controller.currentIndex.value,
                  itemBuilder: (BuildContext context, int index) {
                    return _pages[index];
                  },
                ))),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.explore), title: Text(_titles[0])),
                BottomNavigationBarItem(
                    icon: Icon(Icons.keyboard), title: Text(_titles[1])),
                //  BottomNavigationBarItem(                icon: Icon(Icons.store), title: Text(_titles[2])),
                BottomNavigationBarItem(
                    icon: Icon(Icons.equalizer), title: Text(_titles[3])),
                BottomNavigationBarItem(
                    icon: Icon(Icons.face), title: Text(_titles[4])),
              ],
              currentIndex: this.controller.currentIndex.value,
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey[700],
              onTap: (index) {
                this.controller.setCurrentPageIndex(index);
              },
              type: BottomNavigationBarType.fixed,
            )));
  }
}
