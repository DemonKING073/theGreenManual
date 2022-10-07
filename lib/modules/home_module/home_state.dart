import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/modules/create_module/create_screen.dart';
import 'package:the_green_manual/modules/create_module/create_state.dart';
import 'package:the_green_manual/modules/inventory_module/inventory_screen.dart';
import 'package:the_green_manual/modules/inventory_module/inventory_state.dart';
import 'package:the_green_manual/modules/profile_module/profile_screen.dart';
import 'package:the_green_manual/modules/profile_module/profile_state.dart';
import 'package:the_green_manual/modules/resume_module/resume_screen.dart';
import 'package:the_green_manual/modules/resume_module/resume_state.dart';
import 'package:the_green_manual/modules/search_scan_module/search_scan_screen.dart';

class HomeState extends ChangeNotifier {
  HomeState(context) {
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
    const SearchScanScreen(),
    ChangeNotifierProvider(
        create: (_) => ResumeState(), child: const ResumeScreen()),
    ChangeNotifierProvider(
        create: (_) => CreateScreenState(), child: const CreateScreen()),
    ChangeNotifierProvider(
        create: (_) => InventoryState(), child: const InventoryScreen()),
    ChangeNotifierProvider(
        create: (_) => ProfileState(), child: const ProfileScreen())
  ];
}
