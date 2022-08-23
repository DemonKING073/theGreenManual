import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/constants/helper.dart';
import 'package:the_green_manual/screens/Search/searchState.dart';

class Search extends StatelessWidget {
  static const String id = 'search';
  const Search({Key? key}) : super(key: key);

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
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(10))),
              ),
              LSizedBox(),
              Row(
                children: [
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
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(10))),
              ),
              LSizedBox(),
              SearchButton(
                onTap: () {
                  state.searchProducts();
                },
                name: 'Search',
              ),
              LSizedBox(),
              Divider(),
              LSizedBox(),
      
              //  If Product Found      /////
              state.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : state.product!.data!.products == null
                      ? Center(
                          child: Column(
                            children: [
                              Image.asset('assets/icons/Frame.png'),
                              kSizedBox(),
                              Text(
                                'No product to show for',
                                style: kTextStyle().copyWith(color: Colors.grey),
                              ),
                              Text('state.keySearch',
                                  style:
                                      kTextStyle().copyWith(color: Colors.grey)),
                            ],
                          ),
                        )
                      : Column(
                          children: state.product!.data!.products!.map((e) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Text(
                                e.name!,
                                style: kTextStyle().copyWith(color: Colors.grey),
                              ),
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
