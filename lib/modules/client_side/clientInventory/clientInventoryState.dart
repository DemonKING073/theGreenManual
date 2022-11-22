import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/modules/client_side/clientInventory/modal/client_inventory_response.dart';

import '../../../core/http/http.dart';
import '../../../core/services/toast_service.dart';
import '../../../main.dart';

class ClientInventoryState extends BaseState {
  ClientInventoryState() {
    fetchProjects();
  }

  Dio dio = getHttp();
  String? id;
  ClientInventoryResponse? projectState;
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
      } on DioError catch (err) {}
      hideLoadingDialog();
    } else {
      ToastService().w("Please provide a name!");
    }
  }

  fetchProjects() async {
    setLoading(true);
    try {
      var response = await dio.get('/v1/products');
      projectState = ClientInventoryResponse.fromJson(response.data);
      print("mah yaa xu ${response.data}");

      notifyListeners();
    } catch (e) {}
    setLoading(false);
  }

  bool isPressed = false;
  setWaiting(val) {
    isPressed = val;
    notifyListeners();
  }

  deleteProducts(id) async {
    print(id);
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
