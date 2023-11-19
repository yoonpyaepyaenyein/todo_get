import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_get/utils/localization/localization_controller.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LocalizationController>(
        builder: (localizationController) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
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
                    ))
              ],
            ),
            body: Text('Next'.tr),
          );
        },
      ),
    );
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
