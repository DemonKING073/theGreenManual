import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // icon: ImageIcon(AssetImage('assets/icons/home.svg')),
            icon: SvgPicture.asset('assets/icons/home.svg', color: homeState.selectedIndex == 0 ? primaryColor : Colors.grey,),
            label: 'Home',
            // backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            // icon: ImageIcon(AssetImage('assets/icons/resume.png')),
            icon: SvgPicture.asset('assets/icons/resume.svg', color: homeState.selectedIndex == 1 ? primaryColor : Colors.grey,),

            label: 'Resume',
            // backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            // icon: ImageIcon(AssetImage('assets/icons/create.png')),
            icon: SvgPicture.asset('assets/icons/create.svg', color: homeState.selectedIndex == 2 ? primaryColor : Colors.grey,),


            label: 'Create',
            // backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            // icon: ImageIcon(AssetImage('assets/icons/inventory.png')),
            icon: SvgPicture.asset('assets/icons/inventory.svg', color: homeState.selectedIndex == 3 ? primaryColor : Colors.grey,),


            label: 'Inventory',
            // backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/profile.2.png',)),

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
