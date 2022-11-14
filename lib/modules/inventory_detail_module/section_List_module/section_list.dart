import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Sections',
          style: LBoldTextStyle().copyWith(color: Colors.white),
        ),
      ),
      body: state.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: state.productDetails!.data!.product!.sections!.isNotEmpty
                  ? Column(
                      children: state.productDetails!.data!.product!.sections!
                          .map((e) {
                        return InkWell(
                          onTap: () {
                            print('condo');
                            Navigator.pushNamed(context, "/inventory_details",
                                arguments: {
                                  'id': state.inventoryState!.data!.projects!
                                      .first.sId,
                                  'section_name': e.name,
                                  'section' : e
                                });
                          },
                          child: SectionTile(
                            section_name: e.name,
                          ),
                        );
                      }).toList(),
                    )
                  : Center(
                      child: Text(
                        'No section!',
                        style: kBoldTextStyle(),
                      ),
                    ),
            ),
    );
  }
}

class SectionTile extends StatelessWidget {
  String? section_name;
  SectionTile({
    Key? key,
    this.section_name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text(
          section_name!,
          style: kBoldTextStyle(),
        ),
      ]),
    );
  }
}
