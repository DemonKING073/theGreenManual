import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/apiModels/products.dart';
import 'package:the_green_manual/core/http/http.dart';

class InventoryState extends ChangeNotifier {
  Dio dio = getHttp();
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
      var response =
          await dio.get('/v1/products?fields=assignee,name,model&private=true');
      product = Product.fromJson(response.data);
    } catch (e) {}
    setLoading(false);
  }
}
