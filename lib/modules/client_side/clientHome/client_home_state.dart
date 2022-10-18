import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/modules/client_side/admin_module/adminScreen.dart';
import 'package:the_green_manual/modules/client_side/admin_module/adminState.dart';
import 'package:the_green_manual/modules/client_side/clientInventory/clientInventoryScreen.dart';
import 'package:the_green_manual/modules/client_side/clientInventory/clientInventoryState.dart';

class ClientHomeState extends ChangeNotifier {
  int selectedIndex = 1;
  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  List onNavigation = [
    ChangeNotifierProvider(
        create: (_) => ClientInventoryState(), child: ClientInventoryScreen()),
    ChangeNotifierProvider(create: (_) => AdminState(), child: AdminScreen())
  ];
}
