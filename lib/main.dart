import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/core/states/main_state.dart';
import 'package:the_green_manual/modules/home_module/home_screen.dart';
import 'package:the_green_manual/modules/home_module/home_state.dart';
import 'package:the_green_manual/modules/login_module/login_screen.dart';
import 'package:the_green_manual/modules/login_module/login_state.dart';
import 'package:the_green_manual/modules/onbording_modules/add_and_manage/add_and_manage_screen.dart';
import 'package:the_green_manual/modules/onbording_modules/add_and_manage/add_and_manage_state.dart';
import 'package:the_green_manual/modules/onbording_modules/anytime_anywhere/anytime_anywhere_screen.dart';
import 'package:the_green_manual/modules/onbording_modules/private_secure/private_secure_screen.dart';
import 'package:the_green_manual/modules/onbording_modules/private_secure/private_secure_state.dart';
import 'package:the_green_manual/modules/register_module/register_screen.dart';
import 'package:the_green_manual/modules/register_module/register_state.dart';
import 'package:the_green_manual/modules/splash_module/splash_screen.dart';
import 'package:the_green_manual/modules/splash_module/splash_state.dart';
import 'package:the_green_manual/modules/term&conditions/term_condition_screen.dart';
import 'package:the_green_manual/modules/welcome_module/welcome_screen.dart';
import 'package:the_green_manual/screens/Search/search.dart';
import 'package:the_green_manual/screens/contactUs/contactUs.dart';
import 'package:the_green_manual/screens/contactUs/contactUsState.dart';
import 'package:the_green_manual/screens/editProfile/editProfile.dart';
import 'package:the_green_manual/screens/editProfile/editProfileState.dart';
import 'package:the_green_manual/screens/helpAndSupport/helpAndSupport.dart';
import 'package:the_green_manual/screens/homeDisplay/homeDisplay.dart';
import 'package:the_green_manual/screens/homeDisplay/homeDisplayState.dart';
import 'package:the_green_manual/screens/projectDetails/projectDetails.dart';
import 'package:the_green_manual/screens/scannerScreen/scannerScreen.dart';
import 'package:the_green_manual/screens/scannerScreen/scannerState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const TheGreenManual());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class TheGreenManual extends StatelessWidget {
  const TheGreenManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ChangeNotifierProvider(
        create: (_) => MainState(),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => ChangeNotifierProvider(
                  create: (_) => SplashState(),
                  child: const SplashScreen(),
                ),
            '/add_manage': (context) => ChangeNotifierProvider(
                  create: (_) => AddAndManageState(),
                  child: const AddAndManageScreen(),
                ),
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
            '/login': (context) => ChangeNotifierProvider(
                  create: (_) => LoginState(),
                  child: const LoginScreen(),
                ),
            '/home': (context) => ChangeNotifierProvider(
                  create: (_) => HomeState(),
                  child: const HomeScreen(),
                ),
            '/terms_condition': (context) => TermsAndCondition(),
            '/home_display': (context) => ChangeNotifierProvider(
                create: (_) => HomeDisplayState(), child: HomeDisplay()),
            '/search': (context) => Search(),
            '/scanner_screen': (context) => ChangeNotifierProvider(
                create: (_) => ScannerState(), child: ScannerScreen()),
            '/profile_edit': (context) => ChangeNotifierProvider(
                create: (_) => EditProfileState(), child: EditProfile()),
            '/helpAndSupport': (context) => HelpAndSupport(),
            '/contactUs': (context) => ChangeNotifierProvider(
                create: (_) => ContactUsState(), child: ContactUs()),
            '/project_details': (context) => ProjectDetails(),
          },
        ),
      ),
    );
  }
}
