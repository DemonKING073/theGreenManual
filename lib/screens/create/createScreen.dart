import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/constants/helper.dart';
import 'package:the_green_manual/screens/create/createScreenState.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CreateScreenState>(context);
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
          'Create',
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
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextFormField(
                  onChanged: state.onProjectNameChanged,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      hintText: 'Project Name?'),
                ),
                kSizedBox(),
                TextFormField(
                  onChanged: state.onProductNameChanged,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      hintText: 'Product name or Model'),
                ),
                LSizedBox(),
                LSizedBox(),
                ButtonWithIcon(
                  onTap: () {},
                  icon: Icons.edit_outlined,
                  name: 'Create Section',
                )
              ],
            ),
            Button(
              onTap: () {},
              name: 'Create',
            ),
          ],
        ),
      ),
    );
  }
}
