import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  void onInit() {
    super.onInit();
    _searchResults = getAllNews();
  }

  TextEditingController _searchQueryController = TextEditingController();
  TextEditingController get searchQueryController => _searchQueryController;

  late Future<List> _searchResults;
  Future<List> get searchResults => _searchResults;

  Future<List> getAllNews() async {
    try {
      var dio = Dio();
      String url =
          "https://newsapi.org/v2/everything?q=everything&apiKey=9d92b77ad3da46339185a14972111be0";
      final response = await dio.get(url);
      update();
      return response.data["articles"];
    } catch (e) {
      print("Error============> ${e}");
      update();
      return [];
    }
  }

  Future<List> searchQuery() async {
    if (_searchQueryController.text != "") {
      try {
        var dio = Dio();
        String url =
            "https://newsapi.org/v2/everything?q=${_searchQueryController.text}&apiKey=9d92b77ad3da46339185a14972111be0";
        final response = await dio.get(url);
        return response.data["articles"];
      } catch (e) {
        print("Error============> ${e}");
        update();
        return [];
      }
    }
    return [];
  }

  updateSearchResults() async {
    _searchResults = searchQuery();
    update();
  }

  refreshData() {
    if (_searchQueryController.text != "") {
      _searchResults = searchQuery();
    } else {
      _searchResults = getAllNews();
    }
    update();
  }
}
