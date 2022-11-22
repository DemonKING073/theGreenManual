import 'package:flutter/material.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
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
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(2, 1), // Shadow position
                          ),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height * 0.28,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            mHeightSpan,
                            SizedBox(
                              width: 120,
                              child: Image.asset(
                                'assets/icons/search.png',
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .12,
                            ),
                            const Text(
                              'Search',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            kSizedBox(),
                            const Text(
                              'Search your product',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Color(0xFF6B6B6B),
                              ),
                            ),
                            const Text(
                              'manual ',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6B6B6B),
                                fontSize: 10,
                              ),
                            ),
                            const Text(
                              'by product name',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6B6B6B),
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  navigatorKey.currentState!.pushNamed('/scanner_screen');
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(2, 1), // Shadow position
                          ),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height * 0.28,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            mHeightSpan,
                            SizedBox(
                              width: 120,
                              child: Image.asset(
                                'assets/icons/scan.png',
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .12,
                            ),
                            const Text(
                              'Scan',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            kSizedBox(),
                            const Text(
                              'Search your product',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Color(0xFF6B6B6B),
                              ),
                            ),
                            const Text(
                              'manual by scanning the ',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6B6B6B),
                                fontSize: 10,
                              ),
                            ),
                            const Text(
                              'qr code provided by the',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6B6B6B),
                                fontSize: 10,
                              ),
                            ),
                            const Text(
                              'manufacturer',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6B6B6B),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
