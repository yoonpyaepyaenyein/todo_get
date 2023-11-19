import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/bottom_nav_bar.dart';
import '../../controller/navbar_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (navBarController) {
        return Scaffold(
          body: navBarController.pageLists[navBarController.currentPageIndex],
          bottomNavigationBar: buildBottomNavBar(navBarController),
        );
      },
    );
  }
}
