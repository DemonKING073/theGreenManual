import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/screens/anyTimeAnywhere/anytimeAnywhere.dart';
import 'package:the_green_manual/screens/home/home.dart';
import 'package:the_green_manual/screens/privateAndSecure/privateAndSecure.dart';
import 'package:the_green_manual/screens/privateAndSecure/privateAndSecureState.dart';
import 'package:the_green_manual/screens/register/register.dart';
import 'package:the_green_manual/screens/register/registerState.dart';
import 'package:the_green_manual/screens/splash/splash.dart';
import 'package:the_green_manual/screens/splash/splashState.dart';
import 'package:the_green_manual/screens/termsAndConditions/termsAndCondition.dart';
import 'package:the_green_manual/screens/welcome/welcome.dart';

import 'screens/addAndManage/addAndManage.dart';

void main() async {
  await GetStorage.init();
  runApp(TheGreenManual());
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class TheGreenManual extends StatelessWidget {
  const TheGreenManual({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => ChangeNotifierProvider(
            create: (_) => SplashState(context), child: SplashScreen()),
        AddAndManage.id: (context) => AddAndManage(),
        AnyTimeAnyWhere.id: (context) => AnyTimeAnyWhere(),
        PrivateAndSecure.id: (context) => ChangeNotifierProvider(
            create: (_) => PrivateAndSecureState(), child: PrivateAndSecure()),
        Welcome.id: (context) => Welcome(),
        RegisterScreen.id: (context) => ChangeNotifierProvider(
            create: (_) => RegisterState(), child: RegisterScreen()),
        TermsAndCondition.id: (context) => TermsAndCondition(),
        Home.id : (context) => Home(),
      },
    );
  }
}
