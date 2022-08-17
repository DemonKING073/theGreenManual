import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/screens/profile/profileState.dart';

import '../../constants/constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProfileState>(context);

    showLanguageUpdateDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  // insetPadding: EdgeInsets.zero,
                  // title: Text('Select Language', style: kBoldTextStyle()),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: primaryColor, child: Icon(Icons.language, color: Colors.white, size: 30,),),
                        kSizedBox(),
                        Text('Select Language', style: kBoldTextStyle()),
                        kSizedBox(),
                        DropdownButton(
                            isExpanded: true,
                            hint: Text('Select your Prefered Language'),
                            value: state.selectedLanguage,
                            items: state.language
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(
                                      e,
                                      style: kTextStyle().copyWith(fontSize: 14),
                                    ),
                                    value: e,
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              state.onLanguageChanged(val as String);
                              setState(() {});
                            }),
                      ],
                    ),
                  ),

                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        "Cancel",
                        style: kTextStyle().copyWith(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                        child: Text(
                          'Update',
                          style: kTextStyle().copyWith(color: primaryColor),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        }),
                  ],
                );
              },
            );
          });
    }

    showLogoutConfirmationDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  // insetPadding: EdgeInsets.zero,
                  title: Text('Log Out!', style: kBoldTextStyle()),
                  content: Text('Are you sure you want to logout?'),

                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        "Cancel",
                        style: kTextStyle().copyWith(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                        child: Text(
                          'Log Out',
                          style: kTextStyle().copyWith(color: primaryColor),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        }),
                  ],
                );
              },
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: Text(
          'Profile',
          style: LBoldTextStyle(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: ImageIcon(AssetImage('assets/icons/mic.png')))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 26,
                          backgroundImage:
                              AssetImage('assets/images/luffy.jpg'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            'Will Billings',
                            style:
                                kBoldTextStyle().copyWith(color: Colors.white),
                          ),
                          Text(
                            '@willbillings',
                            style: kTextStyle().copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        navigatorKey.currentState!.pushNamed('/profile_edit');
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 24,
                      ))
                ],
              ),
            ),
            LSizedBox(),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  profileButtons(
                    title: 'My Account',
                    description: 'Make Changes to your Account',
                    icons: Icons.person_outline,
                    onTap: () {},
                  ),
                  LSizedBox(),
                  profileButtons(
                      title: 'Language',
                      description: 'Select Language for Manual',
                      icons: Icons.language,
                      onTap: () {
                        showLanguageUpdateDialog(context);
                      }),
                  LSizedBox(),
                  profileButtons(
                      title: 'Log out',
                      description: 'Further secure your account for safety',
                      icons: Icons.logout,
                      onTap: () {
                        showLogoutConfirmationDialog(context);
                      }),
                ],
              ),
            ),
            LSizedBox(),
            Text(
              'More',
              style: kBoldTextStyle(),
            ),
            LSizedBox(),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  profileButtonsWithOutDescription(
                    title: 'Help And Support',
                    icons: Icons.support_agent,
                    onTap: () {
                      navigatorKey.currentState!.pushNamed('/helpAndSupport');
                    },
                  ),
                  LSizedBox(),
                  profileButtonsWithOutDescription(
                      title: 'About App', icons: Icons.info, onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class profileButtons extends StatelessWidget {
  String title;
  String description;
  IconData icons;
  Function onTap;
  profileButtons(
      {required this.title,
      required this.description,
      required this.icons,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Icon(
                  icons,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: kBoldTextStyle()),
                  Text(
                    description,
                    style:
                        kTextStyle().copyWith(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
            ],
          ),
          Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Colors.grey,
            size: 24,
          )
        ],
      ),
    );
  }
}

class profileButtonsWithOutDescription extends StatelessWidget {
  String title;
  IconData icons;
  Function onTap;
  profileButtonsWithOutDescription(
      {required this.title, required this.icons, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Icon(
                  icons,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: kBoldTextStyle()),
                ],
              ),
            ],
          ),
          Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Colors.grey,
            size: 24,
          )
        ],
      ),
    );
  }
}
