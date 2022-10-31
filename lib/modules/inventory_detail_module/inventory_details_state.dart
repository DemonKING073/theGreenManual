// ignore_for_file: avoid_print, empty_catches

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:load/load.dart';
import 'package:the_green_manual/apiModels/single_product_response.dart';

import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';

import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';

import 'package:the_green_manual/modules/inventory_module/modals/inventory_respones.dart';

class InventoryDetailState extends BaseState {
  late InventoryItem item;

  QuillController controller = QuillController.basic();

  InventoryResponse? inventoryState;

  SingleProductResponse? productDetails;

  InventoryDetailState(context) {
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
    } catch (err) {}
  }

  fetchProductDetails() async {
    try {
      final response = await dio.get(
          "/v1/products/${inventoryState!.data!.projects!.first.product!.sId}");
      productDetails = SingleProductResponse.fromJson(response.data);
      print(response);
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
      if (productDetails!.data!.product!.sections != null &&
          productDetails!.data!.product!.sections!.isNotEmpty) {
        selectedSection = productDetails!.data!.product!.sections?.first.sId;
        notifyListeners();
        if (productDetails!.data!.product!.category != "personal") {
          sectionBody =
              productDetails!.data!.product!.sections!.first.content ??
                  "Empty Section!";
          notifyListeners();
        }
      }
    } on DioError {}
    setLoading(false);
  }

  String? selectedSection;

  dynamic quillData;

  updateSection() async {
    var quill = jsonEncode(controller.document.toDelta().toJson());

    var data = {
      "content": quill.toString(),
      "comment": DateTime.now().toUtc().toIso8601String(),
      "saveAsPublic": true,
    };
    showLoadingDialog();
    print("----------------------------------------------------->");
    print(data);
    try {
      await dio.patch("/v1/sections/$selectedSection/add-content", data: data);
      ToastService().s("Updated successfully!");
      fetchProductDetails();
    } on DioError {}
    hideLoadingDialog();
  }

  String sectionName = "";

  onSectionNameChanged(String val) {
    sectionName = val;
    notifyListeners();
  }

  Sections? sectionItem;

  onSelectedSectionChanged(Sections val) {
    selectedSection = val.sId;
    sectionItem = val;
    notifyListeners();
    controller.clear();
    if (productDetails!.data!.product!.category == "Personal") {
      quillData = jsonDecode(sectionItem!.content ?? "");
      controller = QuillController(
          document: Document.fromJson(quillData),
          selection: const TextSelection.collapsed(offset: 0));
      notifyListeners();
    } else {
      sectionBody = val.content ?? "Empty Section!";
      notifyListeners();
    }
  }

  String sectionBody = "";

  bool isPressed = false;
  setWaiting(val) {
    isPressed = val;
    notifyListeners();
  }

  deleteSection(id) async {
    showLoadingDialog();
    try {
      navigatorKey.currentState!.pop();

      await dio.delete('/v1/sections/$id');
      ToastService().s("Section deleted successfully!");
      fetchProjectDetails();
    } on DioError {}
    hideLoadingDialog();
  }

  createSection() async {
    setLoading(true);
    navigatorKey.currentState!.pop();
    if (sectionName.isNotEmpty) {
      try {
        var data = {
          "productId": productDetails!.data!.product!.sId,
          "name": sectionName,
        };
        await dio.post("/v1/sections", data: data);
        fetchProductDetails();
      } on DioError {}
    } else {
      ToastService().w("Please provide section name!");
    }
  }

  String? updatedSectionName;
  onSectionNameUpdated(val) {
    updatedSectionName = val;
    notifyListeners();
  }

  updateSectionName(id) async {
    navigatorKey.currentState!.pop();
    showLoadingDialog();
    var data = {"name": updatedSectionName};
    try {
      await dio.patch('/v1/sections/$id', data: data);
      setLoading(true);
      fetchProductDetails();
    } catch (e) {}
    hideLoadingDialog();
  }
}
