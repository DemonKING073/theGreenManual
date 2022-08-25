// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/modules/project_details_module/models/project_detail_response.dart';

class ProjectDetailsState extends BaseState {
  late String name;

  late String id;

  ProjectDetailsState(context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (args['id'] != null) {
      id = args['id'];
      notifyListeners();
    }
    if (args['name'] != null) {
      name = args['name'];
      notifyListeners();
    }
    fetchProjectDetails();
  }

  Dio dio = getHttp();

  ProjectDetailResponse? projectState;

  fetchProjectDetails() async {
    try {
      final response =
          await dio.get("/v1/projects?_id=6304aa53c9efc0e07d2d273d");
      projectState = ProjectDetailResponse.fromJson(response.data);
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  createSection() async {
    try {
      final response = await dio.post("/v1/sections", data: {
        "productId": projectState!.data!.projects!.first.product!.sId,
      });
      print(response.data);
    } catch (err) {
      print(err);
    }
  }
}
