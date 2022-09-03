// ignore_for_file: empty_catches

import 'package:dio/dio.dart';

import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/states/base_state.dart';
import 'package:the_green_manual/modules/inventory_module/modals/inventory_respones.dart';

class ResumeState extends BaseState {
  Dio dio = getHttp();
  String? id;
  InventoryResponse? projectState;
  ResumeState() {
    fetchProjects();
  }

  fetchProjects() async {
    setLoading(true);
    try {
      var response = await dio.get('/v1/projects/');
      projectState = InventoryResponse.fromJson(response.data);
    } catch (e) {}
    setLoading(false);
  }
}
