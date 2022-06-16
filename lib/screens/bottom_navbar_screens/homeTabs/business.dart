import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/components/containers/news_container.dart';
import 'package:news_app_flutter_hackathon/controllers/home_controller.dart';

import '../../../components/containers/error_container.dart';
import '../../../components/dialogBoxes/my_dialog_box.dart';
import '../../../controllers/bottom_navbar_controller.dart';

class Business extends StatelessWidget {
  BusinessNewsController _businessNewsController =
      Get.put(BusinessNewsController());

  HomeController _homeController = Get.put(HomeController());
  BottomNavbarController _bottomNavbarController =
      Get.put(BottomNavbarController());

  Widget build(BuildContext context) {
    return GetBuilder<BottomNavbarController>(builder: (_) {
      return !_bottomNavbarController.activeCon
          ? MyErrorContainer(
              "Internet Connection Error",
            )
          : GetBuilder<BusinessNewsController>(builder: (_) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      buildBusinessNewsContainer(context),
                    ],
                  ),
                ),
              );
            });
    });
  }

  Widget buildBusinessNewsContainer(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FutureBuilder<List>(
          future: _businessNewsController.businessNews,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return MyDialogBox("Error", snapshot.hasError);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Map newsData = {
                    "title": snapshot.data?[index]['title'],
                    "urlToImage": snapshot.data?[index]['urlToImage'],
                    "author": snapshot.data?[index]['author'],
                    "publishedAt": snapshot.data?[index]['publishedAt'],
                    "content": snapshot.data?[index]['content']
                  };

                  // return Text("${snapshot.data?.length[index]['title']}");
                  return NewsContainer(newsData);
                });
          }),
    );
  }
}
