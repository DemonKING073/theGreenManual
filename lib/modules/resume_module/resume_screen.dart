// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/resume_module/resume_state.dart';

import '../../constants/constant.dart';

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ResumeState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Start where you left',
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
          : state.projectState?.data?.projects?.isEmpty ?? true
              ? const Center(
                  child: Text("No Projects!"),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.builder(
                    itemCount: state.projectState!.data!.projects!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (state.projectState!.data!.projects![index]
                                  .product !=
                              null) {
                            navigatorKey.currentState!.pushNamed(
                                '/resume_details',
                                arguments:
                                    state.projectState!.data!.projects![index]);
                          }
                        },
                        child: ProjectTile(
                          isProductDeleted: state.projectState!.data!
                                      .projects![index].product ==
                                  null
                              ? true
                              : false,
                          onTap: () {},
                          isPrivate: state.projectState!.data!.projects![index]
                                      .product ==
                                  null
                              ? false
                              : state.projectState!.data!.projects![index]
                                          .product!.private ==
                                      true
                                  ? true
                                  : false,
                          projectName:
                              state.projectState!.data!.projects![index].name!,
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}

class ProjectTile extends StatelessWidget {
  String projectName;
  bool isProductDeleted;
  Function onTap;
  bool isPrivate;
  ProjectTile({
    Key? key,
    required this.isPrivate,
    required this.projectName,
    required this.isProductDeleted,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                projectName,
                style: kBoldTextStyle(),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  if (isProductDeleted)
                    const Text(
                      "[ Product Deleted! ]",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 10,
                        fontWeight: FontWeight.w200,
                        color: Colors.red,
                      ),
                    ),
                  if (isPrivate)
                    Icon(
                      Icons.star,
                      color: primaryColor,
                    ),
                  IconButton(
                    onPressed: () {
                      onTap();
                    },
                    // icon: const Icon(
                    //   Icons.more_vert,
                    //   color: Colors.grey,
                    // )
                    icon: ImageIcon(AssetImage('assets/icons/edit.png')),
                  )
                ],
              )
            ],
          ),
        ),
        kSizedBox(),
      ],
    );
  }
}
