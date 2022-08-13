import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/screens/splash/splashState.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SplashState>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
