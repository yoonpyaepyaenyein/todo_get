import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  TextEditingController titleEditingController = TextEditingController();
  List<Task> tasks = [];

  final box = GetStorage();

  @override
  void onInit() {
    // Initialize the tasks list by reading from storage
    readTasks();
    super.onInit();
  }

  void readTasks() {
    tasks = 
        (box.read<List<dynamic>>('@tasks') ?? []).map((taskJson) {
      return Task.fromJson(taskJson);
    }).toList();
    //[Task(),Tsk()]
    update();
  }

  void createTask() {
    Task task = Task(
      id: const Uuid().v1(),
      title: titleEditingController.text,
    );
    // print('${task.title}');
    tasks.add(task);
    print('Task List $tasks');
    update();
    titleEditingController.text = '';
    box.write('@tasks', tasks.map((task) => task.toJson()).toList());

    Get.back();
  }

  void deleteTask(String id) {
    tasks.removeWhere((element) => element.id == id);
    update();
  }

  void updateTask(Task taskItem) {
    print('ud:>> $taskItem');
    final taskIndex = tasks.indexWhere((element) => element.id == taskItem.id);
    debugPrint('$taskIndex');

    final updateTask =
        Task(id: taskItem.id, title: titleEditingController.text);

    tasks[taskIndex] = updateTask;
    update();
    Get.back();
  }

  // void storeTask() {
  //   Task taskToStore = Task(id: '1', title: 'Hello');

  //   debugPrint(jsonEncode(taskToStore.toJson()));
  //   box.write('@task', jsonEncode(taskToStore.toJson()));
  // }

  // void readTask() async {
  //   var storedTask = await (box.read('@task'));

  //   Task task = Task.fromJson(jsonDecode(storedTask));

  //   debugPrint('Stored ${task.title}');
  //   // debugPrint(jsonDecode(storedTask));
  // }
}
