import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/modules/client_side/clientInventoryDetails/ClientInventoryDetailState.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/ui/ui_helpers.dart';
import '../../../constants/constant.dart';

class ClientInventoryDetailScreen extends StatelessWidget {
  const ClientInventoryDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ClientInventoryDetailState>(context);
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
                        mHeightSpan,
                        Center(
                            child: Text(
                          "Enter the section name you want to create",
                          textAlign: TextAlign.center,
                          style: LBoldTextStyle()
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                        mHeightSpan,
                        Row(
                          children: [
                            Text(
                              'Section Name',
                              style: LBoldTextStyle()
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        sHeightSpan,
                        TextFormField(
                          onChanged: state.onSectionNameChanged,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
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
                          state.createSection();
                        }),
                  ],
                );
              },
            );
          });
    }

    showDeleteSectionDialog(BuildContext context, id) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Delete Category?', style: LBoldTextStyle()),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Are you sure you want to delete Category?',
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
                            await state.deleteSection(id);
                          },
                    child: Text(
                      'Delete',
                      style: kTextStyle().copyWith(color: primaryColor),
                    )),
              ],
            );
          });
    }

    showSectionUpdateDialog(BuildContext context, id) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Change Section Name!', style: LBoldTextStyle()),
              content: TextFormField(
                // initialValue: overViewState.products!.data!.first.productName,
                cursorColor: primaryColor,
                onChanged: state.onSectionNameUpdated,
                decoration: InputDecoration(
                  isDense: true,
                  // hintText: "Enter Name",
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
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
                      'Update',
                      style: kTextStyle().copyWith(color: primaryColor),
                    ),
                    onPressed: () async {
                      state.updateSectionName(id);
                      // Navigator.pop(context);
                    }),
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
          // 'Text Title',
          state.productDetails?.data?.product?.name ?? '',
          style: LBoldTextStyle(),
        ),
        actions: [
          if (state.productDetails?.data?.product?.category == "Personal")
            IconButton(
              onPressed: () {
                if (state.productDetails != null) {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  state.updateSection();
                }
              },
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
                          Row(
                            children: state
                                .productDetails!.data!.product!.sections!
                                .map((e) {
                              return InkWell(
                                onLongPress: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: const Icon(Icons.edit),
                                              title: const Text('Edit'),
                                              onTap: () {
                                                Navigator.pop(context);
                                                showSectionUpdateDialog(
                                                    context, e.sId);
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.delete),
                                              title: const Text('Delete'),
                                              onTap: () {
                                                Navigator.pop(context);
                                                showDeleteSectionDialog(
                                                    context, e.sId);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                onTap: () {
                                  state.onSelectedSectionChanged(e);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    // color: Colors.grey[300],
                                    color: state.selectedSection == e.sId!
                                        ? primaryColor
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    e.name!,
                                    style: kBoldTextStyle().copyWith(
                                      color: state.selectedSection == e.sId!
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (state.productDetails!.data!.product!.category ==
                              "Personal")
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
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       if (state.productDetails!.data!.product!.sections!
                  //           .isNotEmpty)
                  //         if (state.productDetails!.data!.product!.category ==
                  //             "Personal")
                  //           QuillToolbar.basic(
                  //             controller: state.controller,
                  //             showUndo: false,
                  //             showRedo: false,
                  //           ),
                  //     ],
                  //   ),
                  // ),
                  if (state.productDetails != null &&
                      state.productDetails!.data!.product!.sections != null &&
                      state.productDetails!.data!.product!.sections!.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          "No Sections",
                          style: kTextStyle(),
                        ),
                      ),
                    ),
                  LSizedBox(),
                  if (state.productDetails!.data!.product!.category ==
                      "Personal")
                    Expanded(
                      child: state.productDetails!.data!.product!.sections ==
                                  null ||
                              state.productDetails!.data!.product!.sections!
                                  .isEmpty
                          ? Container()
                          : Container(),
                    )
                  else
                    Expanded(
                      child: state.sectionBody.isEmpty
                          ? Center(
                              child: Text(state.sectionBody),
                            )
                          : SingleChildScrollView(
                              child: Html(
                                data: state.sectionBody,
                                onLinkTap:
                                    (url, context, attributes, element) async {
                                  Uri hamro = Uri.parse(url.toString());
                                  if (!await launchUrl(
                                    hamro,
                                    mode: LaunchMode.externalApplication,
                                  )) {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                            ),
                    ),
                ],
              ),
            ),
    );
  }
}
