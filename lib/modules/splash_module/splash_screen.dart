import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/modules/splash_module/splash_state.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'SplashScreen';

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Provider.of<SplashState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
