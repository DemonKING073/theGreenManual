// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:the_green_manual/core/states/base_state.dart';

import '../../../apiModels/single_product_response.dart';
import '../../../core/http/http.dart';
import '../../../core/services/toast_service.dart';
import '../../../main.dart';
import '../../inventory_module/modals/inventory_respones.dart';

class ClientInventoryDetailState extends BaseState {
  // late InventoryItem item;
  String? item;

  InventoryResponse? inventoryState;

  SingleProductResponse? productDetails;

  ClientInventoryDetailState(context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    item = args;
    notifyListeners();
    fetchProjectDetails();
    fetchProductDetails();
  }

  Dio dio = getHttp();

  // SingleProduct? singleProductResponse;

  fetchProjectDetails() async {
    setLoading(true);
    try {
      final response = await dio.get("/v1/projects/?_id=$item");
      inventoryState = InventoryResponse.fromJson(response.data);
      notifyListeners();
      fetchProductDetails();
    } catch (err) {}
  }

  fetchProductDetails() async {
    try {
      final response = await dio.get("/v1/products/$item");
      productDetails = SingleProductResponse.fromJson(response.data);
      notifyListeners();
      if (productDetails!.data!.product!.sections != null &&
          productDetails!.data!.product!.sections!.isNotEmpty) {
        selectedSection = productDetails!.data!.product!.sections!.first.sId;
        notifyListeners();
        try {
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

  updateSection() async {}

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
    if (productDetails!.data!.product!.category == "Personal") {
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
