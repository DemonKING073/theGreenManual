// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/modules/client_side/clientInventory/clientInventoryState.dart';

import '../../../constants/constant.dart';
import '../../../main.dart';

class ClientInventoryScreen extends StatelessWidget {
  const ClientInventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ClientInventoryState>(context);

    showDeleteCategory(BuildContext context, id) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Delete Projects?', style: LBoldTextStyle()),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Are you sure you want to delete project?',
                            style: kBoldTextStyle(),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
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
                    onPressed: state.isPressed
                        ? null
                        : () async {
                            await state.deleteProducts(id);
                          },
                    child: Text(
                      'Delete',
                      style: kTextStyle().copyWith(color: primaryColor),
                    )),
              ],
            );
          });
    }

    showEditCategoryName(BuildContext context, id) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Rename Project?', style: LBoldTextStyle()),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Enter new project name?',
                            style: kBoldTextStyle(),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                    kSizedBox(),
                    TextFormField(
                      onChanged: (val) {
                        state.onNewNameChange(val);
                      },
                      decoration: InputDecoration(
                          isDense: true,
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor))),
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
                  onPressed: state.isPressed
                      ? null
                      : () async {
                          await state.onNameSubmit(id);
                        },
                  child: Text(
                    'Update',
                    style: kTextStyle().copyWith(color: primaryColor),
                  ),
                ),
              ],
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
          : state.projectState?.data?.products?.isEmpty ?? true
              ? const Center(
                  child: Text("No Items"),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.builder(
                      itemCount: state.projectState!.data!.products!.length,
                      itemBuilder: (context, index) {
                        // print(
                        //     "yoooo ${state.projectState!.data!.projects![index].product?.private}");
                        // print(
                        //     "yoooo ${state.projectState!.data!.projects![index].product?.sId}");
                        return InkWell(
                          onTap: () {
                            navigatorKey.currentState!.pushNamed(
                              "/client_inventory_details",
                              arguments: state
                                  .projectState!.data!.products![index].sId,
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.projectState!.data!.products![index]
                                          .name!,
                                      style: kBoldTextStyle(),
                                    ),
                                    Row(
                                      children: [
                                        if (state.projectState!.data!
                                                .products![index] ==
                                            null)
                                          const Text(
                                            "[ Product Deleted! ]",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w200,
                                              color: Colors.red,
                                            ),
                                          )
                                        else if (state.projectState!.data!
                                                .products![index].private ==
                                            true)
                                          Icon(
                                            Icons.star,
                                            color: primaryColor,
                                          ),
                                        IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons.text_fields),
                                                        title: const Text(
                                                            'Rename'),
                                                        onTap: () {
                                                          // Navigator.pop(
                                                          //     context);
                                                          // showEditCategoryName(
                                                          //     context,
                                                          //     state
                                                          //         .projectState!
                                                          //         .data!
                                                          //         .products![
                                                          //             index]
                                                          //         .sId);
                                                        },
                                                      ),
                                                      if (state
                                                                  .projectState!
                                                                  .data!
                                                                  .products![
                                                              index] !=
                                                          null)
                                                        ListTile(
                                                          leading: Icon(state
                                                                      .projectState!
                                                                      .data!
                                                                      .products![
                                                                          index]
                                                                      .private ==
                                                                  true
                                                              ? Icons.edit
                                                              : Icons
                                                                  .remove_red_eye),
                                                          title: Text(
                                                            state
                                                                        .projectState!
                                                                        .data!
                                                                        .products![
                                                                            index]
                                                                        .private ==
                                                                    true
                                                                ? 'Edit'
                                                                : "View",
                                                          ),
                                                          onTap: () {
                                                            // Navigator.pop(
                                                            //     context);
                                                            // navigatorKey
                                                            //     .currentState!
                                                            //     .pushNamed(
                                                            //   "/client_inventory_details",
                                                            //   arguments: state
                                                            //       .projectState!
                                                            //       .data!
                                                            //       .products![
                                                            //           index]
                                                            //       .sId,
                                                            // );

                                                            // Navigator.pushNamed(
                                                            //   context,
                                                            //   '/client_inventory_details',
                                                            //   arguments: state
                                                            //       .projectState!
                                                            //       .data!
                                                            //       .products![index].sId,
                                                            // );
                                                          },
                                                        ),
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons.delete),
                                                        title: const Text(
                                                            'Delete'),
                                                        onTap: () {
                                                          // Navigator.pop(
                                                          //     context);
                                                          // showDeleteCategory(
                                                          //   context,
                                                          //   state
                                                          //       .projectState!
                                                          //       .data!
                                                          //       .products![
                                                          //           index]
                                                          //       .sId,
                                                          // );
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.more_vert,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              kSizedBox(),
                            ],
                          ),
                        );
                      }),
                ),
    );
  }
}
