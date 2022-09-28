// ignore_for_file: empty_catches

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';

import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/inventory_module/modals/inventory_respones.dart';

class InventoryState extends BaseState {
  Dio dio = getHttp();
  String? id;
  InventoryResponse? projectState;
  InventoryState() {
    fetchProjects();
  }

  String newName = "";

  onNewNameChange(val) {
    newName = val;
    notifyListeners();
  }

  onNameSubmit(id) async {
    if (newName.isNotEmpty) {
      showLoadingDialog();
      try {
        var data = {
          "name": newName,
        };
        final response = await dio.patch("/v1/projects/$id", data: data);
        newName = "";
        notifyListeners();
        ToastService().s(response.data['status']);
        navigatorKey.currentState!.pop();
        fetchProjects();
      } on DioError catch (err) {
        print(err.response);
      }
      hideLoadingDialog();
    } else {
      ToastService().w("Please provide a name!");
    }
  }

  fetchProjects() async {
    setLoading(true);
    try {
      var response = await dio.get('/v1/projects/');
      projectState = InventoryResponse.fromJson(response.data);
      notifyListeners();
      projectState!.data!.projects!.forEach((element) {
        print(element.product!.private);
      });
    } catch (e) {}
    setLoading(false);
  }

  bool isPressed = false;
  setWaiting(val) {
    isPressed = val;
    notifyListeners();
  }

  deleteProducts(id) async {
    setLoading(true);
    try {
      navigatorKey.currentState!.pop();

      await dio.delete('/v1/projects/$id');
      ToastService().s("Project deleted successfully!");
      fetchProjects();
    } on DioError {}
    setWaiting(false);
  }
}
