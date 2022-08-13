import 'package:flutter/material.dart';

import '../../../constants/constant.dart';

class AnyTimeAnyWhere extends StatelessWidget {
  static const String id = 'AnyTimeAnyWhere';

  const AnyTimeAnyWhere({super.key});

  @override
  Widget build(BuildContext context) {
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
                'assets/images/location.png',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              LSizedBox(),
              LSizedBox(),
              const Text(
                'ANYTIME AND ANYWHERE',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              LSizedBox(),
              const Text('All of your product manuals in a single place'),
              const Text(' for easy access without any hassle'),
              kSizedBox(),
              LSizedBox(),
              LSizedBox(),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/private_secure');
                  },
                  child: Image.asset(
                    'assets/images/button2.png',
                    width: 80,
                  )),
              LSizedBox(),
              LSizedBox(),
              const Text('SKIP',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
