import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/modules/home_module/home_screen.dart';
import 'package:the_green_manual/screens/create/createScreen.dart';
import 'package:the_green_manual/screens/create/createScreenState.dart';
import 'package:the_green_manual/screens/inventory/inventoryScreen.dart';
import 'package:the_green_manual/screens/inventory/inventoryState.dart';
import 'package:the_green_manual/screens/profile/profileScreen.dart';
import 'package:the_green_manual/screens/profile/profileState.dart';
import 'package:the_green_manual/screens/resume/resumeScreen.dart';
import 'package:the_green_manual/screens/resume/resumeState.dart';

class HomeDisplayState extends ChangeNotifier {
  HomeDisplayState(context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      selectedIndex = 3;
      notifyListeners();
    }
  }
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  List onNavigation = [
    // ChangeNotifierProvider(child: Home(), create: (context) => HomeState(),),
    HomeScreen(),
    ChangeNotifierProvider(create: (_) => ResumeState(), child: ResumeScreen()),
    ChangeNotifierProvider(
        create: (_) => CreateScreenState(), child: CreateScreen()),
    ChangeNotifierProvider(
        create: (_) => InventoryState(), child: InventoryScreen()),
    ChangeNotifierProvider(
        create: (_) => ProfileState(), child: ProfileScreen())
  ];
}
