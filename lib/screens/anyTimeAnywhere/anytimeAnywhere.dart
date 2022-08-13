import 'package:flutter/material.dart';
import 'package:the_green_manual/screens/privateAndSecure/privateAndSecure.dart';

import '../../../constants/constant.dart';

class AnyTimeAnyWhere extends StatelessWidget {
  static const String id = 'AnyTimeAnyWhere';

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
                'assets/images/location.png',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              LSizedBox(),
              LSizedBox(),
              Text(
                'ANYTIME AND ANYWHERE',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              LSizedBox(),
              Text('All of your product manuals in a single place'),
              Text(' for easy access without any hassle'),
              kSizedBox(),
              LSizedBox(),
              LSizedBox(),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PrivateAndSecure.id);
                  },
                  child: Image.asset(
                    'assets/images/button2.png',
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
