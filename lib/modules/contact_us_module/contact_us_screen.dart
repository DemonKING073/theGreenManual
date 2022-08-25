import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/constants/helper.dart';
import 'package:the_green_manual/modules/contact_us_module/contact_us_state.dart';

import '../../constants/constant.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ContactUsState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Contact Us',
          style: LBoldTextStyle(),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              onChanged: state.onNameChanged,
              decoration: InputDecoration(
                filled: true,
                hintText: "Name",
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
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
              onChanged: state.onEmailChanged,
              decoration: InputDecoration(
                filled: true,
                hintText: "Email",
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
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
              onChanged: state.onDescriptionChanged,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                hintText: "Description",
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xffE0E0E0)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            LSizedBox(),
            SearchButton(
              onTap: () {},
              name: 'Send',
            )
          ],
        ),
      ),
    );
  }
}
