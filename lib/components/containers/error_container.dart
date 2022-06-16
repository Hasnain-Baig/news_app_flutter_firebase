import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/controllers/bottom_navbar_controller.dart';
import 'package:news_app_flutter_hackathon/screens/login.dart';

class MyErrorContainer extends StatelessWidget {
  String val;

  MyErrorContainer(this.val);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary.withOpacity(.1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${val}",
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
              ),
            ),
            val == "No favourites, You have to log in first!"
                ? TextButton(
                    onPressed: () {
                      Get.to(Login());
                    },
                    child: Text("Log In"))
                : TextButton(
                    onPressed: () {
                      BottomNavbarController().checkUserConnection();
                    },
                    child: Text("Refresh"))
          ],
        ),
      ),
    );
  }
}
