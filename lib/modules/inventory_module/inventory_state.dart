import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/apiModels/products.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/main.dart';

class InventoryState extends ChangeNotifier {
  Dio dio = getHttp();
  String? id;
  Product? product;
  InventoryState() {
    fetchProducts();
  }
  bool isLoading = false;
  setLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  fetchProducts() async {
    setLoading(true);
    try {
      var response = await dio.get('/v1/projects/');
      product = Product.fromJson(response.data);
    } catch (e) {}
    setLoading(false);
  }

  bool isPressed = false;
  setWaiting(val) {
    isPressed = val;
    notifyListeners();
  }

  deleteProducts(id) async {
    setWaiting(true);
    try {
      navigatorKey.currentState!.pop();

      await dio.delete('/v1/products/$id');
      fetchProducts();

      print('successfully deleted');
    } on DioError catch (e) {}
    setWaiting(false);
  }
}
