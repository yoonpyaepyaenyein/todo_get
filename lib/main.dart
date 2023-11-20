import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_get/controller/task_controller.dart';

import 'controller/global_controller.dart';
import 'utils/app_localization.dart';
import 'views/home/home_screen.dart';

void main() async {
  await GetStorage.init();

  Get.put(GlobalController());
  GlobalController.initController();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String changeLanguageCode = box.read('@language') ?? '';
    Get.put(TaskController());
    return ResponsiveSizer(
      builder: (_, __, ___) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        title: 'To Do App',
        locale: Locale(changeLanguageCode),
        translationsKeys: AppLocalization.translationsKey,
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(useMaterial3: true),
        home: const HomeScreen(),
      ),
    );
  }
}
