import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import 'client_home_state.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ClientHomeState>(context);
    return Scaffold(
      body: state.onNavigation.elementAt(state.selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/cInventory.png')),
            label: 'Inventory',
            // backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/profile.2.png')),
            label: 'Admin',
            // backgroundColor: Colors.black
          ),
        ],
        currentIndex: state.selectedIndex,
        selectedItemColor: primaryColor,
        onTap: state.onItemTapped,
      ),
    );
  }
}
