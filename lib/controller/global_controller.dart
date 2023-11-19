import 'package:get/get.dart';

import '../utils/localization/localization_controller.dart';
import 'navbar_controller.dart';

class GlobalController extends GetxController {
  static void initController() {
    Get.put(NavBarController());
    Get.put(LocalizationController());
  }
}
