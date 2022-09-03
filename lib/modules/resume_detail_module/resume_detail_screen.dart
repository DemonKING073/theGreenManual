import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:provider/provider.dart';

import 'package:the_green_manual/modules/resume_detail_module/resume_detail_state.dart';

import '../../constants/constant.dart';

class ResumeDetailScreen extends StatelessWidget {
  const ResumeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ResumeDetailState>(context);

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
          IconButton(
            onPressed: () {
              state.onBookMark();
            },
            icon: Icon(
              Icons.bookmark,
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
                                  state.onSelectedSectionChanged(e);
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
                              // showCreateSection();
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
                        if (state.productDetails!.data!.product!.sections!
                            .isNotEmpty)
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
                    child:
                        state.productDetails!.data!.product!.sections == null ||
                                state.productDetails!.data!.product!.sections!
                                    .isEmpty
                            ? const Center(
                                child: Text("Please add section!"),
                              )
                            : QuillEditor.basic(
                                controller: state.controller,
                                readOnly: true,
                              ),
                  )
                ],
              ),
            ),
    );
  }
}
