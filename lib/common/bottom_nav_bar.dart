import 'package:flutter/material.dart';

import '../controller/navbar_controller.dart';

NavigationBar buildBottomNavBar(NavBarController navBarController) {
  return NavigationBar(
    selectedIndex: navBarController.currentPageIndex,
    onDestinationSelected: (int index) {
      navBarController.changeIndex(index);
    },
    indicatorColor: Colors.amber[800],
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    backgroundColor: Colors.grey.shade100,
    elevation: 0,
    destinations: const [
      NavigationDestination(
        icon: Icon(Icons.home),
        label: 'Home',
        selectedIcon: Icon(Icons.home_filled),
      ),
      NavigationDestination(
        icon: Icon(Icons.done),
        label: 'Done',
        selectedIcon: Icon(Icons.done_all),
      ),
    ],
  );
}
