import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashController _splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 25),
              Center(
                child: Container(
                  child: Text(
                    "NEWZZ APP",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "By Hasnain",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
