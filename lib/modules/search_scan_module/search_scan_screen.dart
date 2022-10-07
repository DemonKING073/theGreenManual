import 'package:flutter/material.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/main.dart';

class SearchScanScreen extends StatelessWidget {
  const SearchScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        offset: const Offset(4, 8), // Shadow position
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
                        const Text('We help develop company'),
                        const Text('websites to be more'),
                        const Text('professional and attractive')
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigatorKey.currentState!.pushNamed('/scanner_screen');
                  // navigatorKey.currentState!.pushNamed('/scanner_result',
                  //     arguments: "63357ac627d15e411b663aed");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(4, 8), // Shadow position
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
                          child: const Icon(
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
                        const Text('We help develop company'),
                        const Text('websites to be more'),
                        const Text('professional and attractive')
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
