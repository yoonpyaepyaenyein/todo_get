import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/task_controller.dart';
import '../../models/task.dart';
import '../../utils/localization/localization_controller.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<TaskController>(
        builder: (TaskController taskController) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Next'.tr),
              actions: [
                GetBuilder<LocalizationController>(
                  builder: (LocalizationController localizationController) {
                    return _languageWidget(
                      localizationController,
                    );
                  },
                ),
              ],
            ),
            body: _taskListWidget(taskController),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showModalBottomSheet(
                isDismissible: false,
                context: context,
                builder: (context) => _bottomModalSheet(
                  context: context,
                  taskController: taskController,
                ),
              ),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget _taskListWidget(TaskController taskController) {
    if (taskController.tasks.isEmpty) {
      return const Center(
        child: Text(
          'Empty tasks! \n Click \'+\' button to add task',
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: taskController.tasks.length,
        itemBuilder: ((BuildContext context, int index) {
          final taskItem = taskController.tasks[index];
          return _taskItemWidget(taskController, taskItem, context);
        }),
      );
    }
  }

  Align _taskItemWidget(
      TaskController taskController, Task taskItem, BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          width: 90.w,
          child: Row(
            children: [
              Checkbox(
                value: taskItem.isDone,
                onChanged: (checkVal) {
                  taskController.isDone(
                    value: checkVal ?? false,
                    taskItem: taskItem,
                  );
                },
              ),
              Expanded(
                child: Text(
                  taskItem.title,
                  style: TextStyle(
                    fontSize: 4.w,
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  taskController.titleEditingController.text = taskItem.title;
                  showModalBottomSheet(
                    isDismissible: false,
                    context: context,
                    builder: (context) => _bottomModalSheet(
                      context: context,
                      taskController: taskController,
                      titleText: 'Update Task',
                      buttonText: 'Update',
                      taskItem: taskItem,
                      isUpdate: true,
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  size: 5.w,
                ),
              ),
              IconButton(
                onPressed: () {
                  taskController.deleteTask(taskItem.id);
                },
                icon: Icon(
                  Icons.delete,
                  size: 5.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomModalSheet({
    required BuildContext context,
    required TaskController taskController,
    String titleText = 'Create Task',
    String buttonText = 'Create',
    Task? taskItem,
    bool isUpdate = false,
  }) {
    return PopScope(
      canPop: false,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.60,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          children: [
            Text(
              titleText,
              style: TextStyle(
                fontSize: 5.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: TextField(
                controller: taskController.titleEditingController,
                decoration: const InputDecoration(
                  hintText: ('Input Task here'),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            ElevatedButton(
              onPressed: () {
                !isUpdate
                    ? taskController.createTask()
                    : taskController.updateTask(taskItem ?? Task.empty);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
              ),
              child: Text(buttonText),
            ),
            ElevatedButton(
                onPressed: () => Get.back(), child: const Text('Cancel'))
          ],
        ),
      ),
    );
  }

  Padding _languageWidget(LocalizationController localizationController) {
    return Padding(
        padding: EdgeInsets.only(right: 2.w),
        child: TextButton(
          onPressed: () {
            localizationController.showLanguageDialog();
          },
          child: Row(
            children: [
              SizedBox(
                height: 6.w,
                width: 8.w,
                child: _currentLanguageFile(localizationController),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey,
              )
            ],
          ),
        ));
  }
}

Widget _currentLanguageFile(LocalizationController controller) {
  switch (controller.appLanguageCode) {
    case 'en':
      return Image.asset(
        'assets/images/en.png',
        fit: BoxFit.cover,
      );
    case 'mm':
      return Image.asset(
        'assets/images/mm.png',
        fit: BoxFit.cover,
      );
    case 'zh':
      return Image.asset(
        'assets/images/zh.png',
        fit: BoxFit.cover,
      );
    default:
      return const SizedBox.shrink();
  }
}
