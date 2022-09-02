import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:provider/provider.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';

import 'package:the_green_manual/modules/inventory_detail_module/inventory_details_state.dart';

import '../../constants/constant.dart';

class InventoryDetailsScreen extends StatelessWidget {
  const InventoryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<InventoryDetailState>(context);

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
                          "Enter the section name you want",
                          style: LBoldTextStyle()
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                        Center(
                            child: Text(
                          "to create",
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
                        // TextFormField(
                        //   onChanged: state.onSectionNameChanged,
                        //   decoration: InputDecoration(
                        //       border: OutlineInputBorder(),
                        //       focusedBorder: OutlineInputBorder(
                        //           borderSide: BorderSide(color: primaryColor))),
                        // ),
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
                          // state.createSection();
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
            onPressed: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              state.updateSection();
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
                              // print(counter);
                              return InkWell(
                                onTap: () {
                                  // state.onSelectedSectionChanged(e.sId);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    // color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    e.name!,
                                    style: kBoldTextStyle().copyWith(
                                      color: state.selectedSection == e.sId!
                                          ? Colors.black
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
                          controller: state.controller,
                          showUndo: false,
                          showRedo: false,
                        ),
                      ],
                    ),
                  ),
                  LSizedBox(),
                  Expanded(
                    child: QuillEditor.basic(
                        controller: state.controller, readOnly: false),
                  )
                ],
              ),
            ),
    );
  }
}
