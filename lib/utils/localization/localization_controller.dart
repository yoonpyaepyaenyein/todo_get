import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LocalizationController extends GetxController {
  final box = GetStorage();
  String appLanguageCode = 'en';

  changeLanguage(String languageCode) async {
    appLanguageCode = languageCode;
    Get.updateLocale(Locale(languageCode));
    box.write('@language', languageCode);
  }

  showLanguageDialog() {
    Get.dialog(Dialog(
      backgroundColor: Colors.grey.shade100,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              changeLanguage('mm');
              Get.back();
            },
            tileColor:
                appLanguageCode == 'mm' ? Colors.white : Colors.transparent,
            dense: true,
            leading: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              width: 8.w,
              height: 8.w,
              child: Image.asset(
                'assets/images/mm.png',
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'မြန်မာ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: appLanguageCode == 'mm' ? FontWeight.bold : null,
              ),
            ),
            trailing: appLanguageCode == 'mm' ? const Icon(Icons.check) : null,
          ),
          ListTile(
            onTap: () {
              changeLanguage('en');
              Get.back();
            },
            tileColor:
                appLanguageCode == 'en' ? Colors.white : Colors.transparent,
            dense: true,
            leading: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.antiAlias,
              width: 8.w,
              height: 8.w,
              child: Image.asset(
                'assets/images/en.png',
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'English',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: appLanguageCode == 'en' ? FontWeight.bold : null,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              changeLanguage('zh');
              Get.back();
            },
            tileColor:
                appLanguageCode == 'zh' ? Colors.white : Colors.transparent,
            dense: true,
            leading: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.antiAlias,
              width: 8.w,
              height: 8.w,
              child: Image.asset(
                'assets/images/china.png',
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'China',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: appLanguageCode == 'zh' ? FontWeight.bold : null,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    box.writeIfNull('@language', appLanguageCode);
    appLanguageCode = box.read('@language');
  }
}
