import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/modules/onbording_modules/private_secure/private_secure_state.dart';

import '../../../../constants/constant.dart';

class PrivateAndSecure extends StatelessWidget {
  static const String id = 'PrivateAndSecure';

  const PrivateAndSecure({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PrivateAndSecureState>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
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
              const Text(
                'PRIVATE AND SECURE',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              LSizedBox(),
              const Text('We keep your information secure with no '),
              const Text('marketing signups and personal data sharing of'),
              const Text(' any kind'),
              kSizedBox(),
              LSizedBox(),
              LSizedBox(),
              InkWell(
                onTap: () {
                  state.getStarted();
                },
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
