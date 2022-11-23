import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:provider/provider.dart';

import 'package:the_green_manual/modules/inventory_detail_module/inventory_details_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constant.dart';

class InventoryDetailsScreen extends StatelessWidget {
  const InventoryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<InventoryDetailState>(context);

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
                        ],
                      ),
                    ),
                  ),
                  LSizedBox(),
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
