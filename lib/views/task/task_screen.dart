import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_get/controller/task_controller.dart';

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
            body: ListView.builder(
                itemCount: taskController.tasks.length,
                itemBuilder: ((BuildContext context, int index) {
                  final taskItem = taskController.tasks[index];
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        width: 90.w,
                        child: Row(
                          children: [
                            taskController.tasks.isNotEmpty
                                ? Expanded(
                                    child: Text(
                                    taskItem.title,
                                    style: TextStyle(
                                      fontSize: 4.w,
                                      color: Colors.black,
                                    ),
                                  ))
                                : const SizedBox.shrink(),
                            IconButton(
                              onPressed: () {},
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
                })),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showBottomSheet(
                context: context,
                builder: (context) => Container(
                  height: MediaQuery.of(context).size.height * 0.60,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Column(
                    children: [
                      Text(
                        'Create Task',
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
                          taskController.createTask();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                        ),
                        child: const Text('Create'),
                      ),
                    ],
                  ),
                ),
              ),
              child: const Icon(Icons.add),
            ),
          );
        },
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
