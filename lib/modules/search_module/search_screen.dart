import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/constants/helper.dart';
import 'package:the_green_manual/modules/search_module/search_state.dart';

class SearchScreen extends StatelessWidget {
  static const String id = 'search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SearchState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'SEARCH',
          style: LBoldTextStyle(),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Name',
                style: kTextStyle(),
              ),
              sSizedBox(),
              TextFormField(
                onChanged: (query) {
                  state.searchName.value = query;
                },
                decoration: InputDecoration(
                    hintText: 'Master Bedroom Lamp',
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(10))),
              ),
              LSizedBox(),
              Row(
                children: const [
                  Expanded(
                      child: Divider(
                    thickness: 2,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Or',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Divider(
                    thickness: 2,
                  )),
                ],
              ),
              LSizedBox(),
              Text(
                'Model Number',
                style: kTextStyle(),
              ),
              sSizedBox(),
              TextFormField(
                onChanged: (query) {
                  state.searchModelNo.value = query;
                },
                decoration: InputDecoration(
                    hintText: '1111-1111-1111-1111',
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(10))),
              ),
              LSizedBox(),
              SearchButton(
                onTap: () {
                  state.search();
                },
                name: 'Search',
              ),
              LSizedBox(),
              const Divider(),
              LSizedBox(),
              state.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : state.searchState == null ||
                          state.searchState!.data!.products!.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              Image.asset('assets/icons/Frame.png'),
                              kSizedBox(),
                              if (state.keySearchModelNo.isNotEmpty &&
                                  state.keySearchName.isNotEmpty)
                                Text(
                                  'No product to show for',
                                  style:
                                      kTextStyle().copyWith(color: Colors.grey),
                                )
                              else
                                const Text("No Product to show"),
                              if (state.keySearchName.isNotEmpty)
                                Text(state.keySearchName,
                                    style: kTextStyle()
                                        .copyWith(color: Colors.grey))
                              else
                                Text(state.keySearchModelNo,
                                    style: kTextStyle()
                                        .copyWith(color: Colors.grey)),
                            ],
                          ),
                        )
                      : Column(
                          children: state.searchState!.data!.products!.map((e) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            // title: Text(
                                            //     'Enter the section name you want to create',
                                            //     style: LTextStyle()),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 100,
                                                        height: 80,
                                                        child: Image.asset(
                                                          "assets/icons/plus.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Text(
                                                        "Enter the  name of ",
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Text(
                                                        "your project.",
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  mHeightSpan,
                                                  Text(
                                                    'Project Name',
                                                    style: kBoldTextStyle(),
                                                  ),
                                                  kSizedBox(),
                                                  TextFormField(
                                                    cursorColor: primaryColor,
                                                    onChanged: state
                                                        .onProjectNameChange,
                                                    decoration: InputDecoration(
                                                      isDense: true,

                                                      // hintMaxLines: 2,
                                                      // hintText: "Enter Unit Price",
                                                      border:
                                                          const OutlineInputBorder(),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryColor),
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
                                                  style: kTextStyle().copyWith(
                                                      color: Colors.grey),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                  child: Text(
                                                    'Add',
                                                    style: kTextStyle()
                                                        .copyWith(
                                                            color:
                                                                primaryColor),
                                                  ),
                                                  onPressed: () {
                                                    state.createProject(
                                                        e.sId ?? "");
                                                  }),
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Text(
                                      e.name!,
                                      style: kTextStyle()
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                sHeightSpan,
                              ],
                            );
                          }).toList(),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
