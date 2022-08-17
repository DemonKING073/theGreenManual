import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/modules/home_module/home_screen.dart';
import 'package:the_green_manual/screens/create/createScreen.dart';
import 'package:the_green_manual/screens/create/createScreenState.dart';
import 'package:the_green_manual/screens/inventory/inventoryScreen.dart';
import 'package:the_green_manual/screens/profile/profileScreen.dart';
import 'package:the_green_manual/screens/resume/resumeScreen.dart';

class HomeDisplayState extends ChangeNotifier{
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  List onNavigation = [
    // ChangeNotifierProvider(child: Home(), create: (context) => HomeState(),),
    HomeScreen(),
    ResumeScreen(),
    ChangeNotifierProvider(
      create: (_) => CreateScreenState(),
      child: CreateScreen()),
    InventoryScreen(),
    ProfileScreen()
    // BillingScreen(),
    // SupportScreen(),
    // MoreScreen(),
  ];
}
