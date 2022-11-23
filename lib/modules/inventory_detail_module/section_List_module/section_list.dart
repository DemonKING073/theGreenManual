// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/main.dart';

import 'package:the_green_manual/modules/inventory_detail_module/section_List_module/section_list_state.dart';

class SectionList extends StatelessWidget {
  const SectionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SectionListState>(context);
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    navigatorKey.currentState!.pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                const Text(
                  "Sections",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 40,
                )
              ],
            ),
          ),
          Expanded(
            child: state.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: state
                            .productDetails!.data!.product!.sections!.isNotEmpty
                        ? Column(
                            children: state
                                .productDetails!.data!.product!.sections!
                                .map((e) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    "/inventory_details",
                                    arguments: {
                                      'id': state.inventoryState!.data!
                                          .projects!.first.sId,
                                      'section_name': e.name,
                                      'section': e
                                    },
                                  );
                                },
                                child: SectionTile(
                                  sectionName: e.name,
                                ),
                              );
                            }).toList(),
                          )
                        : Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'No section!',
                                style: kBoldTextStyle(),
                              ),
                            ),
                          ),
                  ),
          )
        ],
      ),
    ));
  }
}

class SectionTile extends StatelessWidget {
  String? sectionName;
  SectionTile({
    super.key,
    this.sectionName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE4E4E4)),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 18,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text(
          sectionName!,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ]),
    );
  }
}
