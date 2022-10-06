import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:provider/provider.dart';
import 'package:the_green_manual/core/services/toast_service.dart';

import 'package:the_green_manual/modules/resume_detail_module/resume_detail_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constant.dart';

class ResumeDetailScreen extends StatelessWidget {
  const ResumeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ResumeDetailState>(context);

    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: const <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            state.productDetails?.data?.product?.name ?? '',
            style: LBoldTextStyle(),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (state.sectionItem!.content == null ||
                    (state.sectionItem!.content != null &&
                        state.sectionItem!.content!.isEmpty) ||
                    (state.item.product!.private == true &&
                        state.controller.document
                            .toPlainText()
                            .trim()
                            .isEmpty)) {
                  ToastService().w("Empty section cannot be bookmarked");
                } else {
                  state.onBookMark();
                }
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          ],
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
                            ? const Center(
                                child: Text("No Sections!"),
                              )
                            : QuillEditor(
                                controller: state.controller,
                                focusNode: FocusNode(),
                                scrollController: state.quillScrollController,
                                scrollable: true,
                                padding: const EdgeInsets.all(2),
                                autoFocus: true,
                                readOnly: true,
                                expands: true,
                              ),
                        // QuillEditor.basic(
                        //     controller: state.controller,
                        //     readOnly: true,
                        //     keyboardAppearance: Brightness.dark,
                        //     locale: const Locale('en'),
                        //   ),
                      )
                    else
                      Expanded(
                        child: state.sectionBody.isEmpty
                            ? const Center(
                                child: Text("No Sections"),
                              )
                            : SingleChildScrollView(
                                controller: state.htmlController,
                                child: Html(
                                  data: state.sectionBody,
                                  onLinkTap: (url, context, attributes,
                                      element) async {
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
      ),
    );
  }
}
