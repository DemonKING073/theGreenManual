import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/apiModels/products.dart';
import 'package:the_green_manual/core/http/http.dart';

import '../../constants/debouncer.dart';

class SearchState extends ChangeNotifier {
  Dio dio = getHttp();
  Product? product;
  SearchState() {
    fetchProducts();
  }
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

  fetchProducts() async {
    setLoading(true);
    try {
      var response =
          await dio.get('/v1/products?fields=assignee,name,model&private=true');
      product = Product.fromJson(response.data);
      print(response.data);
    } catch (e) {}
    setLoading(false);
  }

  late String keySearchName;
  late String keySearchModelNo;

  bool isSearched = false;

  searchProducts() async {
    setLoading(true);
    try {
      var response = await dio.get(
        '/v1/products?fields=assignee,name,model&private=true&name[regex]=$keySearchName&model[regex]=$keySearchModelNo&model[options]=i',
      );

      product = Product.fromJson(response.data);

      notifyListeners();
    } on DioError catch (e) {
      // TODO
    }
    setLoading(false);
  }

  late Debouncer<String> searchName = Debouncer(Duration(seconds: 1), (query) {
    keySearchName = query;
    notifyListeners();
    searchProducts();
  }, '');

  late Debouncer<String> searchModelNo =
      Debouncer(Duration(seconds: 1), (query) {
    keySearchModelNo = query;
    notifyListeners();
    searchProducts();
  }, '');
}
