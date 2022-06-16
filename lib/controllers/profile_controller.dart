import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/components/dialogBoxes/logout_dialog_box.dart';
import 'package:news_app_flutter_hackathon/controllers/login_controller.dart';

class ProfileController extends GetxController {
  LoginController _loginController = Get.put(LoginController());

  openlogoutDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return LogoutDialogBox();
        });
  }
}
