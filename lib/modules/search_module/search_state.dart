// ignore_for_file: empty_catches, unused_catch_clause

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/apiModels/products.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';

import '../../constants/debouncer.dart';

class SearchState extends ChangeNotifier {
  Dio dio = getHttp();
  Product? product;
  SearchState() {}
  bool isLoading = false;
  setLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  String? productName;
  String? modelNumber;

  onProductNameChanged(val) {
    productName = val;
    notifyListeners();
  }

  onModelNumberChanged(val) {
    modelNumber = val;
    notifyListeners();
  }

  // fetchProducts() async {
  //   setLoading(true);
  //   try {
  //     var response =
  //         await dio.get('/v1/products?fields=assignee,name,model&private=true');
  //     product = Product.fromJson(response.data);
  //     print(response.data);
  //   } catch (e) {}
  //   setLoading(false);
  // }

  String keySearchName = "";
  String keySearchModelNo = "";

  bool isSearched = false;

  searchProductsByName() async {
    setLoading(true);
    try {
      var response = await dio.get(
          '/v1/products?fields=assignee,name,model&private=true&name[regex]=$keySearchName');
      product = Product.fromJson(response.data);

      notifyListeners();
    } on DioError catch (e) {}
    setLoading(false);
  }

  searchProductsByModel() async {
    setLoading(true);
    try {
      var response = await dio.get(
          '/v1/products?fields=assignee,name,model&private=true&model[regex]=$keySearchModelNo&model[options]=i');
      product = Product.fromJson(response.data);

      notifyListeners();
    } on DioError catch (e) {}
    setLoading(false);
  }

  search() {
    if (keySearchModelNo.isEmpty && keySearchName.isEmpty) {
      ToastService().w("Please provide name or model to search!");
    } else {
      if (keySearchModelNo.isNotEmpty) {
        searchProductsByModel();
      } else {
        searchProductsByName();
      }
    }
  }

  late Debouncer<String> searchName =
      Debouncer(const Duration(seconds: 1), (query) {
    keySearchName = query.trim();
    notifyListeners();
    search();
  }, '');

  late Debouncer<String> searchModelNo =
      Debouncer(const Duration(seconds: 1), (query) {
    keySearchModelNo = query.trim();
    notifyListeners();
    search();
  }, '');
}
