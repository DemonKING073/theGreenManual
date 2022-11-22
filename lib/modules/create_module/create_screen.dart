import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/modules/create_module/create_state.dart';

import '../../common/ui/ui_helpers.dart';

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
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: Text(
          'Create',
          style: LBoldTextStyle(),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: ImageIcon(AssetImage('assets/icons/mic.png')))
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextFormField(
                //   onChanged: state.onNameChanged,
                //   cursorColor: primaryColor,
                //   decoration: InputDecoration(
                //       focusedBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(color: primaryColor)),
                //       hintText: 'Project Name?'),
                // ),
                // kSizedBox(),
                // TextFormField(
                //   onChanged: state.onModelChanged,
                //   cursorColor: primaryColor,
                //   decoration: InputDecoration(
                //       focusedBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(color: primaryColor)),
                //       hintText: 'Product name or Model'),
                // ),
                // LSizedBox(),
                LSizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Files',
                      style: kBoldTextStyle(),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor)),
                      onPressed: () {
                        state.pickFile();
                      },
                      child: const Text(
                        'select',
                        style: TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                    )
                  ],
                ),
                sHeightSpan,
                if (state.file != null)
                  Text.rich(
                    TextSpan(children: [
                      const TextSpan(
                        text: "Filename: ",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: state.fileName,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ]),
                  ),
              ],
            ),
            InkWell(
              onTap: (state.file == null || state.isLoading)
                  ? null
                  : () {
                      state.getSignedUrl();
                    },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: (state.isLoading || state.file == null)
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
                      'Create',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    mWidthSpan,
                    if (state.isLoading)
                      const SizedBox(
                        height: 25,
                        width: 25,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
