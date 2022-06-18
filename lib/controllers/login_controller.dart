import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/components/dialogBoxes/my_dialog_box.dart';
import 'package:news_app_flutter_hackathon/controllers/bottom_navbar_controller.dart';
import 'package:news_app_flutter_hackathon/controllers/favourite_controller.dart';
import 'package:news_app_flutter_hackathon/screens/bottom_nav_bar.dart';

class LoginController extends GetxController {
  bool _hidePass = true;
  bool get hidePass => _hidePass;

  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  bool _isLoad = false;
  bool get isLoad => _isLoad;

  Map _userData = {};
  Map get userData => _userData;

  void onInit() {
    super.onInit();
    _emailController.text = "";
    _passwordController.text = "";
  }

  void onClose() {
    super.onClose();

    print("onclose login controller------>");
  }

  hidePassword() {
    _hidePass = !_hidePass;
    update();
  }

  login(context) async {
    print("\nEmail:${_emailController.text}\nPass:${_passwordController.text}");
    update();

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var email = emailController.text;
    var password = passwordController.text;

    if (email != "" && password != "") {
      try {
        _isLoad = true;
        update();

        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        final DocumentSnapshot snapshot =
            await db.collection("users").doc(user.user!.uid).get();
        _isLoad = false;
        update();

        _userData = snapshot.data() as Map;
        print("Snapshot : ${userData}");
        _userData["uid"] = user.user!.uid;
        // loggedIn = true;
        print("User logged in");

        _emailController.clear();
        _passwordController.clear();

        FavouriteController _favController = Get.put(FavouriteController());
        _favController.initFavNews();

        Object e = "Logged In Successfully";

        Get.to(WillPopScope(
            onWillPop: () async => false, child: MyBottomNavBar()));
      } catch (e) {
        _isLoad = false;
        update();
        // print("Error ${e}");
        // Object e = "Internet Connection Error!";
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyDialogBox("Error", e);
            });
      }
    } else {
      Object e = "Some Fields are Empty";
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialogBox("Error", e);
          });
    }
    update();
  }

  logout() {
    FavouriteController _favController = Get.put(FavouriteController());
    _userData = {};
    _favController.initFavNews();

    BottomNavbarController _bottomNavigationBarController =
        Get.put(BottomNavbarController());
    if (_bottomNavigationBarController.currentIndex == 3) {
      print(
          "=============>${_bottomNavigationBarController.currentIndex == 3}");
      _bottomNavigationBarController.decreaseCurrentIndexByOne();
      _bottomNavigationBarController.setCurrentScreenToFavourite();
      Get.back();
    } else {
      Get.back();
    }
    update();
  }
}
