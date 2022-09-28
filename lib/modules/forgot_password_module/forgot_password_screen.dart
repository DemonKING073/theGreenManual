import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/forgot_password_module/forgot_password_state.dart';
import 'package:the_green_manual/modules/login_module/login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ForgotPasswordState>(context);

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    mHeightSpan,
                    mHeightSpan,
                    const Text(
                      "Enter the email address you want ",
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "us to send a password reset code.",
                      textAlign: TextAlign.center,
                    ),
                    LSizedBox(),
                    mHeightSpan,
                    TextFormField(
                      controller: state.emailController,
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
                    InkWell(
                      onTap: state.submitLoading
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              state.onSubmit(context);
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
                              'Send Link',
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
