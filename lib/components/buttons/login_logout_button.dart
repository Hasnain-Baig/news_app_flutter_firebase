import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/controllers/login_controller.dart';
import 'package:news_app_flutter_hackathon/controllers/profile_controller.dart';

import '../../screens/login.dart';

class LoginOrLogoutButton extends StatelessWidget {
  LoginController _loginController = Get.put(LoginController());
  ProfileController _profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return _loginController.userData["uid"] != null
        ? buildLogoutIconButton(context)
        : buildLoginIconButton(context);
  }

  Widget buildLoginIconButton(context) {
    return IconButton(
        tooltip: "Log In",
        icon: Icon(Icons.login),
        onPressed: () {
          Get.to(Login());
        });
  }

  Widget buildLogoutIconButton(context) {
    return IconButton(
        tooltip: "Log Out",
        icon: Icon(Icons.logout),
        onPressed: () {
          _profileController.openlogoutDialog(context);
        });
  }
}
