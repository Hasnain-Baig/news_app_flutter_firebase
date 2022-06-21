import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/controllers/favourite_controller.dart';
import 'package:news_app_flutter_hackathon/screens/bottom_navbar_screens/favourite.dart';
import 'package:news_app_flutter_hackathon/screens/bottom_navbar_screens/home.dart';
import 'package:news_app_flutter_hackathon/screens/bottom_navbar_screens/profile.dart';

import '../components/dialogBoxes/my_dialog_box.dart';
import '../screens/bottom_navbar_screens/search.dart';
import 'home_controller.dart';
import 'search_controller.dart';

class BottomNavbarController extends GetxController {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void onInit() {
    super.onInit();
    checkUserConnection();
  }

  SearchController _searchController = Get.put(SearchController());
  BusinessNewsController _businessNewsController =
      Get.put(BusinessNewsController());
  TopStoriesController _topStoriesController = Get.put(TopStoriesController());
  SportsNewsController _sportsNewsController = Get.put(SportsNewsController());
  HeadlinesController _headlinesController = Get.put(HeadlinesController());

  Widget _currentScreen = Home();
  Widget get currentScreen => _currentScreen;

  bool _activeCon = true;
  bool get activeCon => _activeCon;

  bool _isloading = false;
  bool get isloading => _isloading;
  checkUserConnection() async {
    try {
      _isloading = true;
      update();
      await InternetAddress.lookup('google.com');
      _isloading = false;
      update();
      _activeCon = true;
      _topStoriesController.refreshData();
      _headlinesController.refreshData();
      _businessNewsController.refreshData();
      _sportsNewsController.refreshData();
      _searchController.refreshData();
      update();
    } catch (_) {
      _isloading = false;
      _activeCon = false;
      update();
    }
  }

  changeScreen(value) {
    _currentIndex = value;
    switch (value) {
      case 0:
        _currentScreen = Home();
        break;
      case 1:
        _currentScreen = Search();
        break;
      case 2:
        _currentScreen = Favourite();
        break;
      case 3:
        _currentScreen = Profile();
    }
    checkUserConnection();
    update();
  }

  decreaseCurrentIndexByOne() {
    _currentIndex--;
    update();
  }

  setCurrentScreenToFavourite() {
    _currentScreen = Favourite();
    update();
  }
}
