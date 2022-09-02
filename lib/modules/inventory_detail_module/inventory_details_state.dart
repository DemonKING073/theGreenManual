// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:load/load.dart';
import 'package:the_green_manual/apiModels/single_product_response.dart';

import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';

import 'package:the_green_manual/core/states/base_state.dart';

import 'package:the_green_manual/modules/inventory_module/modals/inventory_respones.dart';
import 'package:the_green_manual/modules/project_details_module/models/project_detail_response.dart';

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

  SingleProduct? singleProductResponse;

  fetchProjectDetails() async {
    setLoading(true);
    try {
      final response = await dio.get("/v1/projects/?_id=${item.sId}");
      print(response.data);
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
      print(response.data);
      productDetails = SingleProductResponse.fromJson(response.data);
      notifyListeners();
      selectedSection = productDetails!.data!.product!.sections!.first.sId;
      notifyListeners();
      quillData =
          jsonDecode(productDetails!.data!.product!.sections!.first.content!);
      print("yo quill data ho $quillData");
      controller = QuillController(
          document: Document.fromJson(quillData),
          selection: const TextSelection.collapsed(offset: 0));
      notifyListeners();
    } on DioError catch (err) {
      print(err.response);
    }
    setLoading(false);
  }

  String? selectedSection;

  dynamic quillData;

  updateSection() async {
    var quill = jsonEncode(controller.document.toDelta().toJson());

    var data = {
      "content": quill.toString(),
      "comment": DateTime.now().toUtc().toIso8601String(),
    };
    showLoadingDialog();
    try {
      await dio.patch("/v1/sections/$selectedSection/add-content", data: data);
      ToastService().s("Updated successfully!");
    } on DioError catch (err) {
      print(err.response);
      print("condo");
    }
    hideLoadingDialog();
  }
}
