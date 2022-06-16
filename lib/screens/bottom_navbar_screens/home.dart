import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/components/buttons/my_switch.dart';
import 'package:news_app_flutter_hackathon/controllers/home_controller.dart';
import 'package:news_app_flutter_hackathon/controllers/login_controller.dart';
import 'package:news_app_flutter_hackathon/screens/bottom_navbar_screens/homeTabs/business.dart';
import 'package:news_app_flutter_hackathon/screens/bottom_navbar_screens/homeTabs/headlines.dart';
import 'package:news_app_flutter_hackathon/screens/bottom_navbar_screens/homeTabs/sports.dart';
import 'package:news_app_flutter_hackathon/screens/bottom_navbar_screens/homeTabs/top_stories.dart';

import '../../components/buttons/login_logout_button.dart';

class Home extends StatelessWidget {
  HomeController _homeController = Get.put(HomeController());
  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: GetBuilder<LoginController>(builder: (_) {
        return Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.menu),
              title: Text("Home"),
              actions: [MySwitch(), LoginOrLogoutButton()],
              backgroundColor: Theme.of(context).colorScheme.primary,
              // leading: Icon(Icons.menu),
              bottom: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Theme.of(context).colorScheme.onPrimary,
                  tabs: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Tab(child: Text("Top Stories")),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Tab(child: Text("Headlines")),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Tab(child: Text("Business News")),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Tab(child: Text("Sports News")),
                    ),
                  ]),
            ),
            body: TabBarView(
                children: [TopStories(), Headlines(), Business(), Sports()]));
      }),
    );
  }
}
