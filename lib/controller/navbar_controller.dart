import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/done/done_task_screen.dart';
import '../views/task/task_screen.dart';

class NavBarController extends GetxController {
  int currentPageIndex = 0;

  void changeIndex(int index) {
    currentPageIndex = index;
    update();
  }

  List<Widget> pageLists = [
    const TaskScreen(),
    const DoneTaskScreen(),
  ];
}
