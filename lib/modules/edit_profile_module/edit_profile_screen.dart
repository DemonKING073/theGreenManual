import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:the_green_manual/constants/helper.dart';
import 'package:the_green_manual/modules/edit_profile_module/edit_profile_state.dart';

import '../../common/ui/ui_helpers.dart';
import '../../constants/constant.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<EditProfileState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: Text(
          'Edit Profile',
          style: LBoldTextStyle(),
        ),
        centerTitle: true,
      ),
      body: state.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/luffy.jpg'),
                      ),
                      LSizedBox(),
                      Text(
                          state.profile!.data!.user!.name == null
                              ? 'No Name'
                              : state.profile!.data!.user!.name!,
                          style: kBoldTextStyle()),
                      Text(state.profile!.data!.user!.email!,
                          style: kTextStyle()),
                      LSizedBox(),
                      TextFormField(
                        onChanged: state.onFullNameChanged,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            hintText: 'What\'s your full Name?'),
                      ),
                      LSizedBox(),
                      TextFormField(
                        onChanged: state.onAddress1Changed,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            hintText: 'Address 1'),
                      ),
                      LSizedBox(),
                      TextFormField(
                        onChanged: state.onAddress2Changed,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            hintText: 'Address 2'),
                      ),
                      // LSizedBox(),
                      // TextFormField(
                      //   onChanged: state.onPhoneNumberChanged,
                      //   cursorColor: primaryColor,
                      //   decoration: InputDecoration(
                      //       prefixIcon: ImageIcon(AssetImage('assets/images/flag.png')),
                      //       focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: primaryColor)),
                      //       hintText: 'Phone Number*'),
                      // ),
                      LSizedBox(),
                      DropdownButton(
                        menuMaxHeight: 5 * 48,
                        hint: Text(
                          'Select your gender *',
                          style: kTextStyle(),
                        ),
                        isExpanded: true,
                        value: state.selectedGender,
                        items: state.gender
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(
                                  e,
                                  style: kTextStyle().copyWith(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          state.onGenderChanged(val as String);
                        },
                      ),
                      LSizedBox(),
                      TextFormField(
                        onChanged: state.onDateOfBirthChanged,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            hintText: 'What is your date of birth?'),
                      ),
                      LSizedBox(),
                      // Button(
                      //   onTap: state.isPressed
                      //       ? null
                      //       : () {
                      //           print('I am pressed');
                      //           state.editProfile();
                      //         },
                      //   name: 'Update Profile',
                      // )
                      InkWell(
                        onTap: state.submitLoading
                            ? null
                            : () {
                                state.editProfile();
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
                                'Update Profile',
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
            ),
    );
  }
}
