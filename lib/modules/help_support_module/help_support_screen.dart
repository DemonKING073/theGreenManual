// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:the_green_manual/main.dart';

import '../../constants/constant.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Help And Support',
          style: LBoldTextStyle(),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              HelpButtons(
                  title: 'Contact Us',
                  icons: Icons.call,
                  onTap: () {
                    navigatorKey.currentState!.pushNamed('/contactUs');
                  }),
              LSizedBox(),
              HelpButtons(
                title: 'FAQs',
                icons: Icons.question_mark,
                onTap: () {
                  navigatorKey.currentState!.pushNamed('/faq');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HelpButtons extends StatelessWidget {
  String title;
  IconData icons;
  Function onTap;
  HelpButtons(
      {super.key,
      required this.title,
      required this.icons,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Icon(
                  icons,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: kBoldTextStyle()),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Colors.grey,
            size: 24,
          )
        ],
      ),
    );
  }
}
