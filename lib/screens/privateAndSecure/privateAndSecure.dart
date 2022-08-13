import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/screens/privateAndSecure/privateAndSecureState.dart';
import 'package:the_green_manual/screens/register/register.dart';
import 'package:the_green_manual/screens/welcome/welcome.dart';

import '../../../constants/constant.dart';

class PrivateAndSecure extends StatelessWidget {
  static const String id = 'PrivateAndSecure';

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PrivateAndSecureState>(context);

    onTap(){
      Navigator.pushNamed(context, Welcome.id);
    }
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
                'assets/images/private.png',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              LSizedBox(),
              LSizedBox(),
              Text(
                'PRIVATE AND SECURE',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              LSizedBox(),
              Text('We keep your information secure with no '),
              Text('marketing signups and personal data sharing of'),
              Text(' any kind'),
              kSizedBox(),
              LSizedBox(),
              LSizedBox(),
              InkWell(
                onTap: onTap,
                child: Image.asset(
                  'assets/images/button3.png',
                  width: 80,
                ),
              ),
              // LSizedBox(),
              // LSizedBox(),
              // Text('SKIP',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
