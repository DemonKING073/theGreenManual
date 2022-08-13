import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/constants/helper.dart';
import 'package:the_green_manual/modules/register_module/register_state.dart';

class RegisterScreen extends StatelessWidget {
  static const String id = 'RegisterScreen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegisterState>(context);

    // onBtnTap() {
    //   state.createAccount();
    // }

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
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text('Later'),
                    ],
                  ),
                  LSizedBox(),
                  kSizedBox(),
                  const Center(
                      child: Text(
                    'Create An Account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                            borderRadius: BorderRadius.circular(10))),
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
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  LSizedBox(),
                  TextFormField(
                    onChanged: state.onPasswordChanged,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  LSizedBox(),
                  // Button(
                  //   name: 'Create Account',
                  //   onTap: onBtnTap,
                  // ),
                  InkWell(
                    onTap: state.isButtonPressed
                        ? null
                        : () {
                            state.createAccount(context);
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: state.isButtonPressed
                            ? LinearGradient(
                                colors: [
                                    primaryColor.withOpacity(0.5),
                                    const Color(0xff7ACCA9).withOpacity(0.5)
                                  ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)
                            : LinearGradient(
                                colors: [primaryColor, const Color(0xff7ACCA9)],
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
                          const SizedBox(
                            width: 5,
                          ),
                          if (state.isButtonPressed)
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
                  const Center(child: Text('Sign In')),
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
          )
        ],
      ),
    );
  }
}
