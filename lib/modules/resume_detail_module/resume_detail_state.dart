// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:the_green_manual/apiModels/single_product_response.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/core/services/local_storage_services.dart';
import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/core/states/base_state.dart';

import 'package:the_green_manual/modules/inventory_module/modals/inventory_respones.dart';
import 'package:the_green_manual/modules/resume_module/model/resume_data.dart';

class ResumeDetailState extends BaseState {
  late InventoryItem item;

  QuillController controller = QuillController.basic();

  InventoryResponse? inventoryState;

  SingleProductResponse? productDetails;

  ResumeDetailState(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    final args = ModalRoute.of(context)!.settings.arguments as InventoryItem;
    item = args;
    notifyListeners();
    fetchProjectDetails();
  }

  serializeAndNavigateToSection() {
    final savedData = LocalStorageService().read(LocalStorageKeys.bookmark);
    if (savedData != null) {
      try {
        Map<String, dynamic> hamroJson = json.decode(savedData.trim());
        bookmarkdata = ResumeData.fromJson(hamroJson);
        notifyListeners();
        for (final element in bookmarkdata!.savedData!) {
          if (element.id == item.sId) {
            selectedSection = element.sectionId;
            notifyListeners();
            if (productDetails!.data!.product!.sections != null ||
                productDetails!.data!.product!.sections!.isNotEmpty) {
              for (var sectionNewItem
                  in productDetails!.data!.product!.sections!) {
                if (sectionNewItem.sId == selectedSection) {
                  navigateToSection(sectionNewItem);
                }
              }
            }
          }
        }
      } catch (err) {}
    }
  }

  navigateToSection(Sections val) {
    sectionItem = val;
    notifyListeners();
    controller.clear();
    if (val.content != null && val.content!.isNotEmpty) {
      quillData = jsonDecode(val.content!);
      controller = QuillController(
          document: Document.fromJson(quillData),
          selection: const TextSelection.collapsed(offset: 0));
      notifyListeners();
    }
  }

  Dio dio = getHttp();

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
      notifyListeners();
      if (productDetails!.data!.product!.sections != null &&
          productDetails!.data!.product!.sections!.isNotEmpty) {
        selectedSection = productDetails!.data!.product!.sections!.first.sId;
        notifyListeners();
        try {
          quillData = jsonDecode(
              productDetails!.data!.product!.sections!.first.content!);
          controller = QuillController(
              document: Document.fromJson(quillData),
              selection: const TextSelection.collapsed(offset: 0));
          notifyListeners();
        } catch (er) {}
      }
      if (productDetails!.data!.product!.sections != null &&
          productDetails!.data!.product!.sections!.isNotEmpty) {
        selectedSection = productDetails!.data!.product!.sections?.first.sId;
        notifyListeners();
      }
      serializeAndNavigateToSection();
    } on DioError catch (err) {}
    setLoading(false);
  }

  String? selectedSection;

  dynamic quillData;

  Sections? sectionItem;

  onSelectedSectionChanged(Sections val) {
    selectedSection = val.sId;
    sectionItem = val;
    notifyListeners();
    controller.clear();
    if (sectionItem!.content != null && sectionItem!.content!.isNotEmpty) {
      quillData = jsonDecode(sectionItem!.content!);
      controller = QuillController(
          document: Document.fromJson(quillData),
          selection: const TextSelection.collapsed(offset: 0));
      notifyListeners();
    }
  }

  ResumeData? bookmarkdata;

  onBookMark() {
    final savedData = LocalStorageService().read(LocalStorageKeys.bookmark);
    bool isDataSaved = false;
    if (savedData != null) {
      try {
        Map<String, dynamic> hamroJson = json.decode(savedData.trim());
        bookmarkdata = ResumeData.fromJson(hamroJson);
        if (bookmarkdata!.savedData != null) {
          for (final element in bookmarkdata!.savedData!) {
            if (item.sId == element.id) {
              element.sectionId = selectedSection;
              notifyListeners();
              final finalData = jsonEncode(bookmarkdata!.toJson()).toString();
              LocalStorageService().write(LocalStorageKeys.bookmark, finalData);
              print(finalData);
              isDataSaved = true;
              notifyListeners();
              break;
            }
          }
        }
        if (!isDataSaved) {
          bookmarkdata!.savedData!.add(SavedData(
            id: item.sId,
            sectionId: selectedSection,
          ));
          final finalData = jsonEncode(bookmarkdata!.toJson()).toString();
          LocalStorageService().write(LocalStorageKeys.bookmark, finalData);
          isDataSaved = true;
          notifyListeners();
        }
      } catch (err) {}
    } else if (savedData == null) {
      final hamroData = ResumeData(
        savedData: [
          SavedData(
            id: item.sId,
            sectionId: selectedSection,
          )
        ],
      );
      final finalData = jsonEncode(hamroData.toJson()).toString();
      LocalStorageService().write(LocalStorageKeys.bookmark, finalData);
      isDataSaved = true;
      notifyListeners();
    }
    if (isDataSaved) {
      ToastService().s("Bookmarked successfully!");
    }
  }
}
