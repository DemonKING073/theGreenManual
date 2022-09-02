// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/inventory_module/inventory_state.dart';

import '../../constants/constant.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<InventoryState>(context);

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
                    child: Text(
                      'Delete',
                      style: kTextStyle().copyWith(color: primaryColor),
                    ),
                    onPressed: state.isPressed
                        ? null
                        : () async {
                            // Navigator.pop(context);
                            await state.deleteProducts(id);
                          }),
                // InkWell(
                //   onTap: state.isPressed ? null : ,
                //   child: Text('Delete', style: kTextStyle(),))
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
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.builder(
                  itemCount: state.product!.data!.products!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        navigatorKey.currentState!.pushNamed(
                          "/inventory_details",
                          arguments: state.product!.data!.products![index].sId,
                        );
                      },
                      // child: ProjectTile(
                      //   projectName:
                      //       state.product!.data!.products![index].name!,
                      //   // projectName: 'project name',
                      // ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.product!.data!.products![index].name!,
                                  style: kBoldTextStyle(),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                ListTile(
                                                  leading: new Icon(Icons.edit),
                                                  title: new Text('Edit'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                ListTile(
                                                  leading:
                                                      new Icon(Icons.delete),
                                                  title: new Text('Delete'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    showDeleteCategory(
                                                        context,
                                                        state
                                                            .product!
                                                            .data!
                                                            .products![index]
                                                            .sId);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: Colors.grey,
                                    ))
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

// class ProjectTile extends StatelessWidget {
//   String projectName;
//   ProjectTile({
//     super.key,
//     required this.projectName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(10)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 projectName,
//                 style: kBoldTextStyle(),
//               ),
//               IconButton(
//                   onPressed: () {
//                     showModalBottomSheet(
//                         context: context,
//                         builder: (context) {
//                           return Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               ListTile(
//                                 leading: new Icon(Icons.edit),
//                                 title: new Text('Edit'),
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                               ListTile(
//                                 leading: new Icon(Icons.delete),
//                                 title: new Text('Delete'),
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             ],
//                           );
//                         });
//                   },
//                   icon: const Icon(
//                     Icons.more_vert,
//                     color: Colors.grey,
//                   ))
//             ],
//           ),
//         ),
//         kSizedBox(),
//       ],
//     );
//   }
// }
