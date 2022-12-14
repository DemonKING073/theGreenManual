import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/constants/helper.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/register_module/register_state.dart';

class RegisterScreen extends StatelessWidget {
  static const String id = 'RegisterScreen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegisterState>(context);

    faceBookLogin() {}

    appleLogin() async {}

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
                            navigatorKey.currentState!.pushNamed("/login");
                          },
                          child: const Text('Later'),
                        ),
                      ],
                    ),
                    LSizedBox(),
                    kSizedBox(),
                    const Center(
                        child: Text(
                      'Create An Account',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
                    LSizedBox(),
                    TextFormField(
                      onChanged: state.onNameChanged,
                      decoration: InputDecoration(
                        hintText: 'Name',
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
                        if (value == null || value.isEmpty) {
                          return "Name is required!";
                        }
                        return null;
                      },
                    ),
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
                        RegExp mail = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                        if (value == null || value.isEmpty) {
                          return "Email is required!";
                        } else if (!mail.hasMatch(value)) {
                          return "Please provide valid email!";
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
                        RegExp upperCase = RegExp(r'(?=.*?[A-Z])');
                        RegExp lowerCase = RegExp(r'(?=.*?[a-z])');
                        RegExp number = RegExp(r'(?=.*?[0-9])');
                        RegExp special = RegExp(r'^[a-zA-Z0-9]+$');
                        if (value == null || value.isEmpty) {
                          return "Password is required!";
                        } else if (!upperCase.hasMatch(value)) {
                          return "Please use at least one Upper case letter!";
                        } else if (!lowerCase.hasMatch(value)) {
                          return "Please use at least one Lower case letter!";
                        } else if (!number.hasMatch(value)) {
                          return "Please use at least one number!";
                        } else if (special.hasMatch(value)) {
                          return "Please use at least one special character!";
                        }
                        return null;
                      },
                    ),
                    LSizedBox(),
                    InkWell(
                      onTap: state.submitLoading
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              state.createAccount(context);
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
                              'Create Account',
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
                    LSizedBox(),
                    Center(
                      child: InkWell(
                        onTap: () {
                          navigatorKey.currentState!.pushNamed("/login");
                        },
                        child: const Text('Sign In'),
                      ),
                    ),
                    LSizedBox(),
                    const Divider(thickness: 2),
                    LSizedBox(),
                    // WhiteButton(
                    //   name: 'Login With Facebook',
                    //   onTap: faceBookLogin,
                    //   image: 'assets/images/facebookLogo.png',
                    // ),
                    // LSizedBox(),
                    WhiteButton(
                      name: 'Login With Google',
                      onTap: () {
                        state.googleLogIn(context);
                      },
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
