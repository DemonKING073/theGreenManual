import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/constants/helper.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/login_module/login_state.dart';

bool canPop(BuildContext context) {
  final NavigatorState? navigator = Navigator.maybeOf(context);
  return navigator != null && navigator.canPop();
}

class LoginScreen extends StatelessWidget {
  static const String id = 'RegisterScreen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LoginState>(context);

    faceBookLogin() {}
    googleLogin() {}
    appleLogin() {}
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9).withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Form(
                key: state.formKey,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (canPop(context)) {
                              navigatorKey.currentState!.pop();
                            }
                          },
                          child: const Text('Later'),
                        ),
                      ],
                    ),
                    LSizedBox(),
                    kSizedBox(),
                    const Center(
                        child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
                    LSizedBox(),
                    TextFormField(
                      onChanged: state.onEmailChanged,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Email Address',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required!";
                        }
                        return null;
                      },
                    ),
                    LSizedBox(),
                    TextFormField(
                      onChanged: state.onPasswordChanged,
                      obscureText: state.isPasswordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: state.onVisibilityChanged,
                          icon: state.isPasswordVisible
                              ? Icon(
                                  Icons.visibility_off,
                                  color: primaryColor,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: primaryColor,
                                ),
                        ),
                        hintText: 'Password',
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (value == null || value.isEmpty) {
                          return "Password is required!";
                        } else if (!regex.hasMatch(value)) {
                          return "Please provide strong password!";
                        }
                        return null;
                      },
                    ),
                    LSizedBox(),
                    // Button(
                    //   name: 'Create Account',
                    //   onTap: onBtnTap,
                    // ),
                    InkWell(
                      onTap: state.submitLoading
                          ? null
                          : () {
                              state.submitLogin(context);
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: state.submitLoading
                              ? LinearGradient(
                                  colors: [
                                      primaryColor.withOpacity(0.5),
                                      const Color(0xff7ACCA9).withOpacity(0.5)
                                    ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)
                              : LinearGradient(
                                  colors: [
                                      primaryColor,
                                      const Color(0xff7ACCA9)
                                    ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Sign in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            mWidthSpan,
                            if (state.submitLoading)
                              const SizedBox(
                                height: 25,
                                width: 25,
                                child: Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    kSizedBox(),
                    InkWell(
                      onTap: () {
                        navigatorKey.currentState!.pushNamed("/register");
                      },
                      child: const Center(
                        child: Text('Create Account'),
                      ),
                    ),
                    LSizedBox(),
                    const Divider(thickness: 2),
                    LSizedBox(),
                    WhiteButton(
                      name: 'Login With Facebook',
                      onTap: faceBookLogin,
                      image: 'assets/images/facebookLogo.png',
                    ),
                    LSizedBox(),
                    WhiteButton(
                      name: 'Login With Google',
                      onTap: googleLogin,
                      image: 'assets/images/googleLogo.png',
                    ),
                    LSizedBox(),
                    WhiteButton(
                      name: 'Login With Apple',
                      onTap: appleLogin,
                      image: 'assets/images/appleLogo.png',
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
