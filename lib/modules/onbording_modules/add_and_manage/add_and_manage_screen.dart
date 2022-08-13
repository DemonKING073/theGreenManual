import 'package:flutter/material.dart';

import '../../../constants/constant.dart';

class AddAndManageScreen extends StatelessWidget {
  static const String id = 'AddAndManage';

  const AddAndManageScreen({super.key});

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
                'assets/images/green.png',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              LSizedBox(),
              LSizedBox(),
              const Text(
                'ADD AND MANAGE',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              LSizedBox(),
              const Text('The ultimate and the easiest way to add'),
              const Text('and manage your product manual.'),
              kSizedBox(),
              LSizedBox(),
              LSizedBox(),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/anytime_anywhere');
                  },
                  child: Image.asset(
                    'assets/images/button1.png',
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
