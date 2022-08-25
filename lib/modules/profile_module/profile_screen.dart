// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/profile_module/profile_state.dart';

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
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: primaryColor,
                          child: const Icon(
                            Icons.language,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        kSizedBox(),
                        Text('Select Language', style: kBoldTextStyle()),
                        kSizedBox(),
                        DropdownButton(
                            isExpanded: true,
                            hint: const Text('Select your Prefered Language'),
                            value: state.selectedLanguage,
                            items: state.language
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style:
                                          kTextStyle().copyWith(fontSize: 14),
                                    ),
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
                  content: const Text('Are you sure you want to logout?'),

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

                          LocalStorageService()
                              .clear(LocalStorageKeys.accessToken);
                          navigatorKey.currentState!.pushNamedAndRemoveUntil(
                              "/login", (route) => false);
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
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Profile',
          style: LBoldTextStyle(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const ImageIcon(AssetImage('assets/icons/mic.png')))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 26,
                          backgroundImage:
                              AssetImage('assets/images/luffy.jpg'),
                        ),
                      ),
                      const SizedBox(
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
                      icon: const Icon(
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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

class profileButtons extends StatefulWidget {
  String title;
  String description;
  IconData icons;
  Function onTap;
  profileButtons(
      {super.key,
      required this.title,
      required this.description,
      required this.icons,
      required this.onTap});

  @override
  State<profileButtons> createState() => _profileButtonsState();
}

class _profileButtonsState extends State<profileButtons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Icon(
                  widget.icons,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: kBoldTextStyle()),
                  Row(
                    children: [
                      Text(
                        widget.description,
                        overflow: TextOverflow.ellipsis,
                        style: kTextStyle()
                            .copyWith(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          const Icon(
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
      {super.key,
      required this.title,
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
              const SizedBox(
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
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Colors.grey,
            size: 24,
          )
        ],
      ),
    );
  }
}
