import 'package:flutter/material.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/main.dart';

import '../../../constants/constant.dart';
import '../../constants/helper.dart';

class Welcome extends StatelessWidget {
  static const String id = 'Welcome';

  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    onTap() {
      LocalStorageService().write(LocalStorageKeys.isFirstTime, "yes");
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil('/register', (route) => false);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/profile.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                LSizedBox(),
                LSizedBox(),
                const Text(
                  'Hey! Welcome',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                LSizedBox(),
                const Text('We are ready to dilever our features to'),
                const Text('build and organise your manuals. '),
                kSizedBox(),
                LSizedBox(),
                LSizedBox(),
                Button(
                  name: 'GET STARTED',
                  onTap: onTap,
                )
              ]),
        ),
      ),
    );
  }
}
