import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';

import '../../../apiModels/single_product_response.dart';
import '../../inventory_module/modals/inventory_respones.dart';

class SectionListState extends BaseState {
  Dio dio = getHttp();
  InventoryResponse? inventoryState;
  SingleProductResponse? productDetails;
  String? selectedSection;
  InventoryResponse? projectState;

  dynamic quillData;
  QuillController controller = QuillController.basic();
  late InventoryItem item;

  SectionListState(context) {
    setLoading(true);
    final args = ModalRoute.of(context)!.settings.arguments as InventoryItem;
    item = args;
    notifyListeners();
    fetchProjectDetails();
  }

  fetchProjectDetails() async {
    setLoading(true);
    try {
      final response = await dio.get("/v1/projects/?_id=${item.sId}");
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
      productDetails = SingleProductResponse.fromJson(response.data);
      // print(productDetails!.data!.product!.sections);
      notifyListeners();
    } on DioError catch (err) {
      ToastService().e(err.message);
    }
    setLoading(false);
  }
}
