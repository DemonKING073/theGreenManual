import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:the_green_manual/main.dart';

import '../../constants/constant.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Help And Support',
          style: LBoldTextStyle(),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: EdgeInsets.all(10),
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
                  title: 'FAQs', icons: Icons.question_mark, onTap: () {})
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
  HelpButtons({required this.title, required this.icons, required this.onTap});

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
              SizedBox(
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
          Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Colors.grey,
            size: 24,
          )
        ],
      ),
    );
  }
}
