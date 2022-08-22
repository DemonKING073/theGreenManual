import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/screens/resume/resumeState.dart';

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
        iconTheme: IconThemeData(
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
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () {
                  navigatorKey.currentState!.pushNamed('/project_details');
                },
                child: ListView.builder(
                    itemCount: state.product!.data!.products!.length,
                    itemBuilder: (context, index) {
                      return ProjectTile(
                        onTap: () {},
                        projectName:
                            state.product!.data!.products![index].name!,
                      );
                    }),
              ),
            ),
    );
  }
}

class ProjectTile extends StatelessWidget {
  String projectName;
  Function onTap;
  ProjectTile({
    required this.projectName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              IconButton(
                  onPressed: () {
                    onTap();
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ))
            ],
          ),
        ),
        kSizedBox(),
      ],
    );
  }
}
