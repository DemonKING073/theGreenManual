// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/apiModels/products.dart';
import 'package:the_green_manual/apiModels/singleProjectResponse.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/project_details_module/models/project_detail_response.dart';

class InventoryDetailState extends BaseState {
  // late String name;

  late String id;

  ProductsModel? productsModel;

  InventoryDetailState(context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    if (args != null) {
      print(args);
      id = args;
      notifyListeners();
    }

    fetchProjectDetails();
  }

  bool isLoading = false;
  setLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  Dio dio = getHttp();

  SingleProduct? singleProductResponse;

  fetchProjectDetails() async {
    setLoading(true);
    try {
      final response = await dio.get("/v1/products/$id");
      singleProductResponse = SingleProduct.fromJson(response.data);
      // singleProductResponse.data!.product!.sections
      print(response);
      notifyListeners();
    } catch (err) {
      print(err);
    }
    setLoading(false);
  }

  

  String? selectedSection;
  onSelectedSectionChanged(val) {
    selectedSection = val;
    print(selectedSection);
    notifyListeners();
  }

  String? sectionName;
  onSectionNameChanged(val) {
    sectionName = val;
    notifyListeners();
  }

  

  fetchSingleSection() {}

  createSection() async {
    var data = {"productId": id, "name": sectionName};

    try {
      await dio.post('/v1/sections', data: data);
      fetchProjectDetails();
      ToastService().s('Created Successfully');
      navigatorKey.currentState!.pop();
      print('created successfully');
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
