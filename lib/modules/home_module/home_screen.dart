import 'package:flutter/material.dart';
import 'package:the_green_manual/main.dart';

import '../../constants/constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text('Home', style: LBoldTextStyle()),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.support_agent,
                ))
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: MediaQuery.of(context).size.width * 0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 25,
                            backgroundColor: primaryColor,
                            child: Image.asset('assets/icons/search.png')),
                        kSizedBox(),
                        Text(
                          'Search',
                          style: LBoldTextStyle(),
                        ),
                        kSizedBox(),
                        Text('We help develop company'),
                        Text('websites to be more'),
                        Text('professional and attractive')
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigatorKey.currentState!.pushNamed('/scanner_screen');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: primaryColor,
                          // child: Image.asset(
                          //   'assets/icons/Search.png',
                          // )
                          child: Icon(
                            Icons.fit_screen_sharp,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        kSizedBox(),
                        Text(
                          'Scan',
                          style: LBoldTextStyle(),
                        ),
                        kSizedBox(),
                        Text('We help develop company'),
                        Text('websites to be more'),
                        Text('professional and attractive')
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
