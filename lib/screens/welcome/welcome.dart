import 'package:flutter/material.dart';
import 'package:the_green_manual/screens/anyTimeAnywhere/anytimeAnywhere.dart';
import 'package:the_green_manual/screens/register/register.dart';

import '../../../constants/constant.dart';
import '../../constants/helper.dart';

class Welcome extends StatelessWidget {
  static const String id = 'Welcome';



  @override
  Widget build(BuildContext context) {

      onTap(){
    Navigator.pushNamed(context, RegisterScreen.id);
  }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/profile.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                LSizedBox(),
                LSizedBox(),
                Text(
                  'Hey! Welcome',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                LSizedBox(),
                Text('We are ready to dilever our features to'),
                Text('build and organise your manuals. '),
                kSizedBox(),
                LSizedBox(),
                LSizedBox(),
                Button(name: 'GET STARTED', onTap: onTap,)
              ]
            ),
          ),
        ),
      ),
    );
  }
}

