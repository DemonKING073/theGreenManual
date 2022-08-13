import 'package:flutter/material.dart';
import 'package:the_green_manual/screens/anyTimeAnywhere/anytimeAnywhere.dart';

import '../../../constants/constant.dart';

class AddAndManage extends StatelessWidget {
  static const String id = 'AddAndManage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/green.png',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              LSizedBox(),
              LSizedBox(),
              Text(
                'ADD AND MANAGE',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              LSizedBox(),
              Text('The ultimate and the easiest way to add'),
              Text('and manage your product manual.'),
              kSizedBox(),
              LSizedBox(),
              LSizedBox(),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AnyTimeAnyWhere.id);
                  },
                  child: Image.asset(
                    'assets/images/button1.png',
                    width: 80,
                  )),
              LSizedBox(),
              LSizedBox(),
              Text('SKIP',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
