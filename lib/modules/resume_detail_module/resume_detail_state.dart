// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:the_green_manual/apiModels/single_product_response.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/states/base_state.dart';

import 'package:the_green_manual/modules/inventory_module/modals/inventory_respones.dart';

class ResumeDetailState extends BaseState {
  late InventoryItem item;

  QuillController controller = QuillController.basic();

  InventoryResponse? inventoryState;

  SingleProductResponse? productDetails;

  ResumeDetailState(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    final args = ModalRoute.of(context)!.settings.arguments as InventoryItem;
    item = args;
    notifyListeners();
    fetchProjectDetails();
  }

  Dio dio = getHttp();

  // SingleProduct? singleProductResponse;

  fetchProjectDetails() async {
    setLoading(true);
    try {
      final response = await dio.get("/v1/projects/?_id=${item.sId}");
      inventoryState = InventoryResponse.fromJson(response.data);
      notifyListeners();
      fetchProductDetails();
    } catch (err) {
      print(err);
    }
  }

  fetchProductDetails() async {
    try {
      final response = await dio.get(
          "/v1/products/${inventoryState!.data!.projects!.first.product!.sId}");
      productDetails = SingleProductResponse.fromJson(response.data);
      notifyListeners();

      if (productDetails!.data!.product!.sections != null &&
          productDetails!.data!.product!.sections!.isNotEmpty) {
        selectedSection = productDetails!.data!.product!.sections!.first.sId;
        notifyListeners();
        try {
          quillData = jsonDecode(
              productDetails!.data!.product!.sections!.first.content!);
          controller = QuillController(
              document: Document.fromJson(quillData),
              selection: const TextSelection.collapsed(offset: 0));
          notifyListeners();
        } catch (er) {}
      }
    } on DioError catch (err) {}
    setLoading(false);
  }

  String? selectedSection;

  dynamic quillData;

  Sections? sectionItem;

  onSelectedSectionChanged(Sections val) {
    selectedSection = val.sId;
    sectionItem = val;
    notifyListeners();
    controller.clear();
    if (sectionItem!.content != null && sectionItem!.content!.isNotEmpty) {
      quillData = jsonDecode(sectionItem!.content!);
      controller = QuillController(
          document: Document.fromJson(quillData),
          selection: const TextSelection.collapsed(offset: 0));
      notifyListeners();
    }
  }

  onBookMark() {
    print(sectionItem!.sId);
    print(inventoryState!.data!.projects!.first.sId);
    var data = {"bookMarkList": []};
    // LocalStorageService().write(key, value)
  }
}

class BookMarkModel {
  List? bookMarkList;
}

class BookMarkItemModel {
  String? itemId;
  String? sectionId;
  BookMarkItemModel({this.itemId, this.sectionId});

  BookMarkItemModel.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    sectionId = json['section_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['section_id'] = sectionId;
    return data;
  }
}
