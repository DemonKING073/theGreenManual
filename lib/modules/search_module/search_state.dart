// ignore_for_file: empty_catches, unused_catch_clause

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';

import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/search_module/models/product_search_response.dart';

import '../../constants/debouncer.dart';

class SearchState extends ChangeNotifier {
  Dio dio = getHttp();

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

  ProductSearchResponse? searchState;

  searchProductsByName() async {
    setLoading(true);
    try {
      var response = await dio
          .get('/v1/products?name[regex]=$keySearchName&name[options]=i');
      searchState = ProductSearchResponse.fromJson(response.data);
      notifyListeners();
    } on DioError catch (e) {}
    setLoading(false);
  }

  searchProductsByModel() async {
    setLoading(true);
    try {
      var response = await dio
          .get('/v1/products?model[regex]=$keySearchModelNo&model[options]=i');
      searchState = ProductSearchResponse.fromJson(response.data);
      notifyListeners();
    } on DioError catch (e) {}
    setLoading(false);
  }

  String? newSection;
  onNewSectionChanged(val) {
    newSection = val;
    notifyListeners();
  }

  createProject(String hamroId) async {
    showLoadingDialog();
    print("machikne");
    var data = {"name": newSection, "productId": hamroId};
    print("condo $data");
    try {
      var res = await dio.post('/v1/projects', data: data);
      navigatorKey.currentState!.pop();
      navigatorKey.currentState!
          .pushNamed('/home', arguments: 'inventory screen');
      print(res.data);
      ToastService().s('Created successfully');
    } on DioError catch (e) {
      ToastService().e(e.response!.data['message']);
      print("error condo $data");
    }
    hideLoadingDialog();
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
