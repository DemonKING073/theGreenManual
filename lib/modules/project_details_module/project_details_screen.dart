import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

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

    QuillController controller = QuillController.basic();

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
          state.name,
          style: LBoldTextStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print(controller.document.toDelta());
            },
            icon: Icon(
              Icons.save,
              color: primaryColor,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Container(
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
              child: Row(
                children: [
                  QuillToolbar.basic(
                    controller: controller,
                    showUndo: false,
                    showRedo: false,
                  ),
                ],
              ),
            ),
            Expanded(
              child: QuillEditor.basic(controller: controller, readOnly: false),
            )
          ],
        ),
      ),
    );
  }
}

// child:
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 1,
//                 offset: const Offset(0, 3), // changes position of shadow
//               ),
//             ],
//           ),
//           padding: EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: MediaQuery.of(context).size.height * 0.04),
//           // child: Column(
//           //   children: [
//           //     Row(
//           //       children: [
//           //         Text(
//           //           'Assembly/SetUp',
//           //           style: LBoldTextStyle()
//           //               .copyWith(fontWeight: FontWeight.w600),
//           //         ),
//           //       ],
//           //     ),
//           //     kSizedBox(),
//           //     Text(
//           //       'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
//           //       style: kTextStyle(),
//           //     ),
//           //     LSizedBox(),
//           //     SingleChildScrollView(
//           //       scrollDirection: Axis.horizontal,
//           //       child: Row(
//           //         children: [
//           //           Image.asset(
//           //             'assets/images/anime1.jpeg',
//           //             width: MediaQuery.of(context).size.width * 0.4,
//           //           ),
//           //           const SizedBox(
//           //             width: 10,
//           //           ),
//           //           Image.asset(
//           //             'assets/images/anime1.jpeg',
//           //             width: MediaQuery.of(context).size.width * 0.4,
//           //           ),
//           //           const SizedBox(
//           //             width: 10,
//           //           ),
//           //           Image.asset(
//           //             'assets/images/anime1.jpeg',
//           //             width: MediaQuery.of(context).size.width * 0.4,
//           //           ),
//           //         ],
//           //       ),
//           //     ),
//           //     LSizedBox(),
//           //     Row(
//           //       children: [
//           //         Text(
//           //           'Assembly/SetUp',
//           //           style: LBoldTextStyle()
//           //               .copyWith(fontWeight: FontWeight.w600),
//           //         ),
//           //       ],
//           //     ),
//           //     kSizedBox(),
//           //     Text(
//           //       'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
//           //       style: kTextStyle(),
//           //     ),
//           //   ],
//           // ),
//         ),
