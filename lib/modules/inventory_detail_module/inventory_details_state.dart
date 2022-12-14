// ignore_for_file: avoid_print, empty_catches

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:the_green_manual/apiModels/single_product_response.dart';

import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';

import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';

import 'package:the_green_manual/modules/inventory_module/modals/inventory_respones.dart';

class InventoryDetailState extends BaseState {
  late InventoryItem item;

  InventoryResponse? inventoryState;

  SingleProductResponse? productDetails;
  String? sId;
  Sections? section;

  InventoryDetailState(context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args['id'] != null) {
      sId = args['id'];
    }
    if (args['section_name'] != null) {
      sectionName = args['section_name'];
    }
    if (args['section'] != null) {
      section = args['section'];
      onSelectedSectionChanged(section!);
    }
    if (args['section_id'] != null) {
      selectedSection = args['section_id'];
      notifyListeners();
    }
    fetchProjectDetails();
  }

  Dio dio = getHttp();

  // SingleProduct? singleProductResponse;

  fetchProjectDetails() async {
    setLoading(true);
    try {
      final response = await dio.get("/v1/projects/?_id=$sId");
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
      notifyListeners();
    } on DioError {}
    setLoading(false);
  }

  String? selectedSection;

  dynamic quillData;

  updateSection() async {}

  late String sectionName;

  onSectionNameChanged(String val) {
    sectionName = val;
    notifyListeners();
    print("this is section $section");
  }

  Sections? sectionItem;

  onSelectedSectionChanged(Sections val) {
    selectedSection = val.sId;
    sectionItem = val;
    notifyListeners();
    sectionBody = val.content ?? "Empty Section!";
    print("yo section $sectionBody");
    notifyListeners();
    setLoading(false);
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
