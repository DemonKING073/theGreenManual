import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/scanner_result_module/scanner_result_state.dart';

class ScannerResultScreen extends StatelessWidget {
  const ScannerResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ScannerResultState>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: sPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      navigatorKey.currentState!.pop();
                    },
                    child: const Icon(Icons.arrow_back_sharp),
                  ),
                  const Text(
                    "Scanner Result",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  )
                ],
              ),
              mHeightSpan,
              mHeightSpan,
              Expanded(
                child: state.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state.productState == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icons/Frame.png',
                                  ),
                                ],
                              ),
                              sHeightSpan,
                              sHeightSpan,
                              const Text(
                                "No Products to show",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Color(0xFF6B6B6B),
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          // title: Text(
                                          //     'Enter the section name you want to create',
                                          //     style: LTextStyle()),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 100,
                                                      height: 80,
                                                      child: Image.asset(
                                                        "assets/icons/plus.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Text(
                                                      "Enter the  name of ",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Text(
                                                      "your project.",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                mHeightSpan,
                                                Text(
                                                  'Project Name',
                                                  style: kBoldTextStyle(),
                                                ),
                                                kSizedBox(),
                                                TextFormField(
                                                  cursorColor: primaryColor,
                                                  onChanged:
                                                      state.onProjectNameChange,
                                                  decoration: InputDecoration(
                                                    isDense: true,

                                                    // hintMaxLines: 2,
                                                    // hintText: "Enter Unit Price",
                                                    border:
                                                        const OutlineInputBorder(),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: primaryColor),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(
                                                "Cancel",
                                                style: kTextStyle().copyWith(
                                                    color: Colors.grey),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                                child: Text(
                                                  'Add',
                                                  style: kTextStyle().copyWith(
                                                      color: primaryColor),
                                                ),
                                                onPressed: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  state.createProject();
                                                }),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Text(
                                    state.productState!.data!.product!.name!,
                                    style: kTextStyle()
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                              ),
                              sHeightSpan,
                            ],
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
