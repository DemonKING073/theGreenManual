// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/apiModels/products.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/modules/project_details_module/models/project_detail_response.dart';

class ProjectDetailsState extends BaseState {
  // late String name;

  late String id;

  ProductsModel? productsModel;

  ProjectDetailsState(context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    id = args;
    notifyListeners();

    fetchProjectDetails();
  }

  Dio dio = getHttp();

  SingleProduct? singleProductResponse;

  fetchProjectDetails() async {
    setLoading(true);
    try {
      final response = await dio.get("/v1/products/$id");
      singleProductResponse = SingleProduct.fromJson(response.data);
      notifyListeners();
    } catch (err) {}
    setLoading(false);
  }

  createSection() async {
    try {
      final response = await dio.post("/v1/sections", data: {
        // "productId": singleProductResponse!.data!.projects!.first.product!.sId,
      });
    } catch (err) {}
  }
}
