import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  void onInit() {
    super.onInit();
  }

  void onClose() {
    super.onInit();
  }

  late BuildContext _ctx;
  BuildContext get ctx => _ctx;

  getContext(context) {
    _ctx = context;
  }
}

class TopStoriesController extends GetxController {
  void onInit() {
    super.onInit();
    _topStories = getTopStoriesData();
  }

  late Future<List> _topStories;
  Future<List> get topStories => _topStories;

  Future<List> getTopStoriesData() async {
    try {
      var dio = Dio();
      String url =
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=9d92b77ad3da46339185a14972111be0";
      final response = await dio.get(url);
      return response.data["articles"];
    } catch (e) {
      return [];
    }
  }

  refreshData() {
    _topStories = getTopStoriesData();
    update();
  }
}

class HeadlinesController extends GetxController {
  void onInit() {
    super.onInit();
    _headlines = getHeadlinesData();
  }

  late Future<List> _headlines;
  Future<List> get headlines => _headlines;

  Future<List> getHeadlinesData() async {
    try {
      var dio = Dio();
      String url =
          "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=9d92b77ad3da46339185a14972111be0";
      final response = await dio.get(url);
      return response.data["articles"];
    } catch (e) {
      return [];
    }
  }

  refreshData() {
    _headlines = getHeadlinesData();
    update();
  }
}

class SportsNewsController extends GetxController {
  void onInit() {
    super.onInit();
    _sportsNews = getSportsNewsData();
  }

  late Future<List> _sportsNews;
  Future<List> get sportsNews => _sportsNews;

  Future<List> getSportsNewsData() async {
    try {
      var dio = Dio();
      String url =
          "https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=9d92b77ad3da46339185a14972111be0";
      final response = await dio.get(url);

      return response.data["articles"];
    } catch (e) {
      return [];
    }
  }

  refreshData() {
    _sportsNews = getSportsNewsData();
    update();
  }
}

class BusinessNewsController extends GetxController {
  void onInit() {
    super.onInit();
    _businessNews = getBusinessNewsData();
  }

  late Future<List> _businessNews;
  Future<List> get businessNews => _businessNews;

  Future<List> getBusinessNewsData() async {
    try {
      var dio = Dio();
      String url =
          "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=9d92b77ad3da46339185a14972111be0";
      final response = await dio.get(url);

      return response.data["articles"];
    } catch (e) {
      print("Error============> ${e}");
      return [];
    }
  }

  refreshData() {
    _businessNews = getBusinessNewsData();
    update();
  }
}
