import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAnimationController extends GetxController {
  double _margin = 0;
  double get margin => _margin;

  double _opacity = 0;
  double get opacity => _opacity;

  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1))
        .then((value) => {myFormContainerAnimation()});
    print("oninit animation done");
  }

  void onClose() {
    super.onClose();
  }

  myFormContainerAnimation() {
    _margin = 50;
    _opacity = 1;
    update();
  }
}
