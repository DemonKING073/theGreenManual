import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
import 'package:the_green_manual/common/ui/widgets/k_text_form_field.dart';
import 'package:the_green_manual/modules/project_details_module/project_details_state.dart';

import '../../constants/constant.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProjectDetailsState>(context);

    showCreateSection() async {
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
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        sHeightSpan,
                        const Text("Enter the section name you want to create"),
                        sHeightSpan,
                        const KTextFormField(
                          label: "Section Name",
                        )
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
                          'Add',
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
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          // 'Text Title',
          state.singleProductResponse?.data?.product?.name ?? '',
          style: LBoldTextStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.save,
              color: primaryColor,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: state.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey[100],
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         vertical: 5, horizontal: 10),
                          //     decoration: BoxDecoration(
                          //       color: Colors.grey[300],
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Text('Assembly/Set up',
                          //         style:
                          //             kBoldTextStyle().copyWith(color: Colors.black)),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         vertical: 5, horizontal: 10),
                          //     decoration: BoxDecoration(
                          //       color: Colors.grey[300],
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Text('Section 2',
                          //         style:
                          //             kBoldTextStyle().copyWith(color: Colors.black)),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         vertical: 5, horizontal: 10),
                          //     decoration: BoxDecoration(
                          //       color: Colors.grey[300],
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Text('Section 3',
                          //         style:
                          //             kBoldTextStyle().copyWith(color: Colors.black)),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         vertical: 5, horizontal: 10),
                          //     decoration: BoxDecoration(
                          //       color: Colors.grey[300],
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Text('Section 4',
                          //         style:
                          //             kBoldTextStyle().copyWith(color: Colors.black)),
                          //   ),
                          // ),
                          InkWell(
                            onTap: () {
                              showCreateSection();
                            },
                            child: Container(
                              height: 40,
                              width: 60,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  LSizedBox(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(),
                  ),
                ],
              ),
            ),
    );
  }
}
