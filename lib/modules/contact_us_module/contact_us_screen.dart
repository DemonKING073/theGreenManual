import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
import 'package:the_green_manual/constants/helper.dart';

import '../../../constants/constant.dart';
import 'contact_us_state.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ContactUsState>(context);
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Contact Us',
          style: LBoldTextStyle(),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: state.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide your name!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Name",
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              LSizedBox(),
              TextFormField(
                controller: state.emailController,
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
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Email",
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              LSizedBox(),
              TextFormField(
                controller: state.descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide description about your issue!";
                  }
                  return null;
                },
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Description",
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFFF5F5F5), width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              LSizedBox(),
              InkWell(
                onTap: state.submitLoading
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          state.onSubmit();
                        }
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
                        'Send',
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
                            child:
                                CircularProgressIndicator(color: Colors.white),
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
    );
  }
}
