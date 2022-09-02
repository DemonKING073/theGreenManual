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
                        navigatorKey.currentState!.pushNamed(
                          "/inventory_details",
                          arguments: state.product!.data!.products![index].sId,
                        );
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
                  onPressed: () {
                    PopupMenuButton<int>(
                      itemBuilder: (context) => [
                        // popupmenu item 1
                        PopupMenuItem(
                          value: 1,
                          // row has two child icon and text.
                          child: Row(
                            children: [
                              Icon(Icons.star),
                              SizedBox(
                                // sized box with width 10
                                width: 10,
                              ),
                              Text("Get The App")
                            ],
                          ),
                        ),
                        // popupmenu item 2
                        PopupMenuItem(
                          value: 2,
                          // row has two child icon and text
                          child: Row(
                            children: [
                              Icon(Icons.chrome_reader_mode),
                              SizedBox(
                                // sized box with width 10
                                width: 10,
                              ),
                              Text("About")
                            ],
                          ),
                        ),
                      ],
                      offset: Offset(0, 100),
                      color: Colors.grey,
                      elevation: 2,
                    );
                  },
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
