import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/controllers/bottom_navbar_controller.dart';
import 'package:news_app_flutter_hackathon/controllers/login_controller.dart';

class MyBottomNavBar extends StatelessWidget {
  BottomNavbarController _bottomNavigationBarController =
      Get.put(BottomNavbarController());

  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavbarController>(builder: (_) {
      return GetBuilder<LoginController>(builder: (_) {
        return Scaffold(
          body: PageStorage(
              bucket: PageStorageBucket(),
              child: _bottomNavigationBarController.currentScreen),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _bottomNavigationBarController.currentIndex,
              onTap: (value) {
                _bottomNavigationBarController.changeScreen(value);
              },
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              showSelectedLabels: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              // fixedColor: Theme.of(context).colorScheme.primary,
              selectedItemColor: Theme.of(context).colorScheme.onPrimary,
              unselectedItemColor:
                  Theme.of(context).colorScheme.onPrimary.withOpacity(.6),
              items: _loginController.userData["uid"] != null
                  ? [
                      BottomNavigationBarItem(
                        label: 'Home',
                        icon: Icon(Icons.home),
                      ),
                      BottomNavigationBarItem(
                        label: 'Search',
                        icon: Icon(Icons.search),
                      ),
                      BottomNavigationBarItem(
                        label: 'Favourite',
                        icon: Icon(Icons.favorite),
                      ),
                      BottomNavigationBarItem(
                        label: 'Profile',
                        icon: Icon(Icons.account_circle),
                      ),
                    ]
                  : [
                      BottomNavigationBarItem(
                        label: 'Home',
                        icon: Icon(Icons.home),
                      ),
                      BottomNavigationBarItem(
                        label: 'Search',
                        icon: Icon(Icons.search),
                      ),
                      BottomNavigationBarItem(
                        label: 'Favourite',
                        icon: Icon(Icons.favorite),
                      ),
                    ]),
        );
      });
    });
  }
}
