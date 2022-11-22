import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/states/base_state.dart';

import '../../../apiModels/single_product_response.dart';
import '../../inventory_module/modals/inventory_respones.dart';

class SectionListState extends BaseState {
  Dio dio = getHttp();
  InventoryResponse? inventoryState;
  SingleProductResponse? productDetails;
  String? selectedSection;
  InventoryResponse? projectState;

  dynamic quillData;
  QuillController controller = QuillController.basic();
  late InventoryItem item;

  SectionListState(context) {
    final args = ModalRoute.of(context)!.settings.arguments as InventoryItem;
    item = args;
    notifyListeners();
    fetchProjectDetails();
  }

  fetchProjectDetails() async {
    setLoading(true);
    try {
      final response = await dio.get("/v1/projects/?_id=${item.sId}");
      inventoryState = InventoryResponse.fromJson(response.data);
      notifyListeners();
      fetchProductDetails();
    } catch (err) {}
  }

  fetchProductDetails() async {
    setLoading(true);
    try {
      final response = await dio.get(
          "/v1/products/${inventoryState!.data!.projects!.first.product!.sId}");
      print("this is data ${response.data}");
      productDetails = SingleProductResponse.fromJson(response.data);
      print(response);
      notifyListeners();
      // if (productDetails!.data!.product!.sections != null &&
      //     productDetails!.data!.product!.sections!.isNotEmpty) {
      //   selectedSection = productDetails!.data!.product!.sections!.first.sId;
      //   notifyListeners();
      //   try {
      //     quillData = jsonDecode(
      //         productDetails!.data!.product!.sections!.first.content!);
      //     controller = QuillController(
      //         document: Document.fromJson(quillData),
      //         selection: const TextSelection.collapsed(offset: 0));
      //     notifyListeners();
      //   } catch (er) {}
      // }
      // if (productDetails!.data!.product!.sections != null &&
      //     productDetails!.data!.product!.sections!.isNotEmpty) {
      //   selectedSection = productDetails!.data!.product!.sections?.first.sId;
      //   notifyListeners();
      //   if (productDetails!.data!.product!.category != "personal") {
      //     sectionBody =
      //         productDetails!.data!.product!.sections!.first.content ??
      //             "Empty Section!";
      //     notifyListeners();
      //   }
      // }
    } on DioError {}
    setLoading(false);
  }
}
