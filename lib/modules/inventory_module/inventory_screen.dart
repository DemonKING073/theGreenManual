// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/inventory_module/inventory_state.dart';

import '../../constants/constant.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<InventoryState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Inventory',
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.builder(
                  itemCount: state.product!.data!.products!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        navigatorKey.currentState!
                            .pushNamed("/project_details", arguments: {
                          "id": state.product!.data!.products![index].sId,
                          "name": state.product!.data!.products![index].name,
                        });
                      },
                      child: ProjectTile(
                        projectName:
                            state.product!.data!.products![index].name!,
                        // projectName: 'project name',
                      ),
                    );
                  }),
            ),
    );
  }
}

class ProjectTile extends StatelessWidget {
  String projectName;
  ProjectTile({
    super.key,
    required this.projectName,
  });

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
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
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