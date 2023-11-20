import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  TextEditingController titleEditingController = TextEditingController();
  List<Task> tasks = [];

  void createTask() {
    Task task = Task(
      id: const Uuid().v1(),
      title: titleEditingController.text,
    );
    // print('${task.title}');
    tasks.add(task);
    // print('Task List $tasks');
    update();
    titleEditingController.text = '';

    Get.back();
  }

  void deleteTask(String id) {
    tasks.removeWhere((element) => element.id == id);
    update();
  }
}
