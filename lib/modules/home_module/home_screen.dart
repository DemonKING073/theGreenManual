import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/modules/home_module/home_state.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = Provider.of<HomeState>(context);
    return Scaffold(
      body: homeState.onNavigation.elementAt(homeState.selectedIndex),
      // bottomNavigationBar: BottomNavBar(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/Home.png')),
            label: 'Home',
            // backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/resume.png')),
            label: 'Resume',
            // backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/create.png')),

            label: 'Create',
            // backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/inventory.png')),

            label: 'Inventory',
            // backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/profile.2.png')),

            label: 'Profile',
            // backgroundColor: Colors.black
          ),
        ],
        currentIndex: homeState.selectedIndex,
        selectedItemColor: primaryColor,
        onTap: homeState.onItemTapped,
      ),
    );
  }
}
