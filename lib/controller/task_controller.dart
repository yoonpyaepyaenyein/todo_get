import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  TextEditingController titleEditingController = TextEditingController();
  List<Task> tasks = [];
  List<Task> doneTasks = [];
  bool checkToggle = false;

  final box = GetStorage();

  @override
  void onInit() {
    // Initialize the tasks list by reading from storage
    readTasks();
    readDoneTasks();
    super.onInit();
  }

  void readTasks() {
    tasks = (box.read<List<dynamic>>('@tasks') ?? []).map((taskJson) {
      return Task.fromJson(taskJson);
    }).toList();
    //[Task(),Tsk()]
    update();
  }

  void readDoneTasks() {
    doneTasks = (box.read<List<dynamic>>('@doneTasks') ?? []).map((taskJson) {
      return Task.fromJson(taskJson);
    }).toList();
    update();
  }

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
    box.write('@tasks', tasks.map((task) => task.toJson()).toList());

    Get.back();
  }

  void deleteTask(String id) {
    tasks.removeWhere((element) => element.id == id);
    update();
  }

  void updateTask(Task taskItem) {
    // print('ud:>> $taskItem');
    final taskIndex = tasks.indexWhere((element) => element.id == taskItem.id);
    // debugPrint('$taskIndex');

    final updateTask =
        Task(id: taskItem.id, title: titleEditingController.text);

    tasks[taskIndex] = updateTask;
    box.write('@tasks', tasks.map((task) => task.toJson()).toList());
    update();
    Get.back();
  }

  void isDone({required bool value, required Task taskItem}) {
    // debugPrint('Value is $value and item is $taskItem');
    var index = tasks.indexWhere((element) => element.id == taskItem.id);
    // debugPrint('index is $index');
    var updateTask = Task(
      id: taskItem.id,
      title: taskItem.title,
      isDone: value,
    );

    tasks[index] = updateTask;
    // debugPrint('list is ${tasks[index].isDone}');
    if (tasks[index].isDone) {
      doneTasks.add(updateTask);
      box.write('@doneTasks',
          doneTasks.map((doneTask) => doneTask.toJson()).toList());
      print('DOne Task is $doneTasks');
      tasks.remove(updateTask);
      box.write('@tasks', tasks.map((task) => task.toJson()).toList());
      print('Tasks is $tasks');
      update();
    } else {
      doneTasks.remove(updateTask);
      tasks.add(updateTask);
    }
  }

  void allRemoveTask() {
    doneTasks.clear();
    update();
    debugPrint('$doneTasks');
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
