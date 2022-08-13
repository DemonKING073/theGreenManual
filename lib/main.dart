import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/modules/onbording_modules/add_and_manage/add_and_manage_screen.dart';
import 'package:the_green_manual/modules/onbording_modules/anytime_anywhere/anytime_anywhere_screen.dart';
import 'package:the_green_manual/modules/onbording_modules/private_secure/private_secure_screen.dart';
import 'package:the_green_manual/modules/onbording_modules/private_secure/private_secure_state.dart';
import 'package:the_green_manual/modules/register_module/register_screen.dart';
import 'package:the_green_manual/modules/register_module/register_state.dart';
import 'package:the_green_manual/modules/splash_module/splash_screen.dart';
import 'package:the_green_manual/modules/splash_module/splash_state.dart';
import 'package:the_green_manual/modules/term&conditions/term_condition_screen.dart';
import 'package:the_green_manual/modules/welcome_module/welcome_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const TheGreenManual());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class TheGreenManual extends StatelessWidget {
  const TheGreenManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => ChangeNotifierProvider(
              create: (_) => SplashState(),
              child: const SplashScreen(),
            ),
        '/add_manage': (context) => const AddAndManage(),
        '/anytime_anywhere': (context) => const AnyTimeAnyWhere(),
        '/private_secure': (context) => ChangeNotifierProvider(
              create: (_) => PrivateAndSecureState(),
              child: const PrivateAndSecure(),
            ),
        '/welcome': (context) => const Welcome(),
        '/register': (context) => ChangeNotifierProvider(
              create: (_) => RegisterState(),
              child: const RegisterScreen(),
            ),
        '/terms_condition': (context) => TermsAndCondition(),
      },
    );
  }
}
