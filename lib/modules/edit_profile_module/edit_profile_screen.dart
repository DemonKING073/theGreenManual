import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          state.isEditable ? 'Edit Profile' : "View Profile",
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
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
                        readOnly: !state.isEditable,
                        controller: state.nameController,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            hintText: 'What\'s your full Name?'),
                      ),
                      LSizedBox(),
                      TextFormField(
                        readOnly: !state.isEditable,
                        controller: state.add1Controller,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            hintText: 'Address 1'),
                      ),
                      LSizedBox(),
                      TextFormField(
                        readOnly: !state.isEditable,
                        controller: state.add2Controller,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            hintText: 'Address 2'),
                      ),
                      LSizedBox(),
                      DropdownButton(
                        menuMaxHeight: 5 * 48,
                        hint: Text(
                          'Select your gender *',
                          style: kTextStyle().copyWith(
                            fontSize: 14,
                          ),
                        ),
                        isExpanded: true,
                        value: state.selectedGender,
                        items: state.gender
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: kTextStyle().copyWith(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: state.isEditable
                            ? (val) {
                                state.onGenderChanged(val as String);
                              }
                            : null,
                      ),
                      LSizedBox(),
                      if (state.isEditable)
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
                                          const Color(0xff7ACCA9)
                                              .withOpacity(0.5)
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
                                        color: Colors.white,
                                      ),
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
