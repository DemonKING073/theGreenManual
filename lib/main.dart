import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:load/load.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/core/states/main_state.dart';
import 'package:the_green_manual/modules/contact_us_module/contact_us_screen.dart';
import 'package:the_green_manual/modules/contact_us_module/contact_us_state.dart';
import 'package:the_green_manual/modules/home_module/home_screen.dart';
import 'package:the_green_manual/modules/home_module/home_state.dart';
import 'package:the_green_manual/modules/inventory_detail_module/inventory_details_screen.dart';
import 'package:the_green_manual/modules/inventory_detail_module/inventory_details_state.dart';
import 'package:the_green_manual/modules/login_module/login_screen.dart';
import 'package:the_green_manual/modules/login_module/login_state.dart';
import 'package:the_green_manual/modules/onbording_modules/add_and_manage/add_and_manage_screen.dart';
import 'package:the_green_manual/modules/onbording_modules/add_and_manage/add_and_manage_state.dart';
import 'package:the_green_manual/modules/onbording_modules/anytime_anywhere/anytime_anywhere_screen.dart';
import 'package:the_green_manual/modules/onbording_modules/private_secure/private_secure_screen.dart';
import 'package:the_green_manual/modules/onbording_modules/private_secure/private_secure_state.dart';
import 'package:the_green_manual/modules/project_details_module/project_details_state.dart';
import 'package:the_green_manual/modules/register_module/register_screen.dart';
import 'package:the_green_manual/modules/register_module/register_state.dart';
import 'package:the_green_manual/modules/resume_detail_module/resume_detail_screen.dart';
import 'package:the_green_manual/modules/resume_detail_module/resume_detail_state.dart';
import 'package:the_green_manual/modules/splash_module/splash_screen.dart';
import 'package:the_green_manual/modules/splash_module/splash_state.dart';
import 'package:the_green_manual/modules/term&conditions/term_condition_screen.dart';
import 'package:the_green_manual/modules/welcome_module/welcome_screen.dart';
import 'package:the_green_manual/modules/search_module/search_screen.dart';
import 'package:the_green_manual/modules/search_module/search_state.dart';
import 'package:the_green_manual/modules/edit_profile_module/edit_profile_screen.dart';
import 'package:the_green_manual/modules/edit_profile_module/edit_profile_state.dart';
import 'package:the_green_manual/modules/help_support_module/help_support_screen.dart';

import 'package:the_green_manual/modules/project_details_module/project_details_screen.dart';
import 'package:the_green_manual/modules/scanner_module/scanner_screen.dart';
import 'package:the_green_manual/modules/scanner_module/scanner_state.dart';

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
    return LoadingProvider(
      themeData: LoadingThemeData(
        tapDismiss: false,
      ),
      child: OKToast(
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
                  create: (_) => HomeState(context), child: const HomeScreen()),
              '/terms_condition': (context) => TermsAndCondition(),
              '/search': (context) => ChangeNotifierProvider(
                  create: (_) => SearchState(), child: const SearchScreen()),
              '/scanner_screen': (context) => ChangeNotifierProvider(
                  create: (_) => ScannerState(), child: const ScannerScreen()),
              '/profile_edit': (context) => ChangeNotifierProvider(
                  create: (_) => EditProfileState(context),
                  child: const EditProfileScreen()),
              '/helpAndSupport': (context) => const HelpAndSupportScreen(),
              '/contactUs': (context) => ChangeNotifierProvider(
                    create: (_) => ContactUsState(),
                    child: const ContactUsScreen(),
                  ),
              '/project_details': (context) => ChangeNotifierProvider(
                    create: (_) => ProjectDetailsState(context),
                    child: const ProjectDetailsScreen(),
                  ),
              '/inventory_details': (context) => ChangeNotifierProvider(
                    create: (_) => InventoryDetailState(context),
                    child: const InventoryDetailsScreen(),
                  ),
              '/resume_details': (context) => ChangeNotifierProvider(
                    create: (_) => ResumeDetailState(context),
                    child: const ResumeDetailScreen(),
                  ),
            },
          ),
        ),
      ),
    );
  }
}
