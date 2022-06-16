import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/dialogBoxes/my_dialog_box.dart';
import 'login_controller.dart';

class FavouriteController extends GetxController {
  void onInit() {
    super.onInit();
    getFavNewsStream();
    initFavNews();
  }

  late List _favNews;
  List get favNews => _favNews;

  late Stream<QuerySnapshot> _favsStream;
  Stream<QuerySnapshot> get favsStream => _favsStream;
  LoginController _loginController = Get.put(LoginController());
  FirebaseFirestore db = FirebaseFirestore.instance;

  initFavNews() async {
    if (_loginController.userData['uid'] != null) {
      var u = await db
          .collection('users')
          .doc(_loginController.userData['uid'])
          .get();
      Map uData = u.data() as Map;
      _favNews = uData['favourites'];
    } else {
      _favNews = [];
    }

    update();
  }

  setFavNews(value) {
    _favNews = value;
  }

  getFavNewsStream() async {
    try {
      _favsStream = await db.collection('users').snapshots();
    } catch (e) {
      print("Error=====>${e}");
    }
  }

  checkFav(obj, context) async {
    if (_loginController.userData['uid'] != null) {
      myIf:
      if (_favNews.length >= 0) {
        for (var i = 0; i < _favNews.length; i++) {
          if (_favNews[i]['title'] == obj['title']) {
            _favNews.removeAt(i);
            update();
            break myIf;
          }
        }
        _favNews.add(obj);
      }
      update();

      try {
        FirebaseFirestore db = FirebaseFirestore.instance;
        var userId = _loginController.userData["uid"];

        await db.collection('users').doc(userId).update(
          {"favourites": _favNews},
        );

        update();
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyDialogBox("Error", "Internet Connection Error");
            });
      }
    } else {
      Object e = "You have to Login First!";
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialogBox("Error", e);
          });
    }
    update();
  }

  containsFavNews(obj) {
    if (_favNews.length > 0) {
      for (var i = 0; i < _favNews.length; i++) {
        if (_favNews[i]['title'] == obj['title']) {
          return true;
        }
      }
      return false;
    } else {
      return false;
    }
    update();
  }
}
