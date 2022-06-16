import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/components/containers/error_container.dart';
import 'package:news_app_flutter_hackathon/components/containers/news_container.dart';
import 'package:news_app_flutter_hackathon/controllers/login_controller.dart';
import 'package:news_app_flutter_hackathon/controllers/search_controller.dart';

import '../../components/buttons/login_logout_button.dart';
import '../../components/buttons/my_switch.dart';
import '../../components/dialogBoxes/my_dialog_box.dart';
import '../../controllers/bottom_navbar_controller.dart';

class Search extends StatelessWidget {
  SearchController _searchController = Get.put(SearchController());
  LoginController _loginController = Get.put(LoginController());
  BottomNavbarController _bottomNavbarController =
      Get.put(BottomNavbarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (_) {
      return GetBuilder<SearchController>(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: Icon(Icons.menu),
            title: Text("Search"),
            actions: [MySwitch(), LoginOrLogoutButton()],
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                buildInputContainer(context),
                GetBuilder<BottomNavbarController>(builder: (_) {
                  return !_bottomNavbarController.activeCon
                      ? MyErrorContainer(
                          "Internet Connection Error",
                        )
                      : buildSearchViews(context);
                }),
              ],
            ),
          ),
        );
      });
    });
  }

  Widget buildInputContainer(context) {
    return GetBuilder<SearchController>(builder: (_) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    controller: _searchController.searchQueryController,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      hintText: "Search",
                      hintStyle: TextStyle(fontSize: 16),
                      border: InputBorder.none,
                    ),
                    cursorColor: Theme.of(context).colorScheme.onSecondary,
                  )),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 50,
              height: 45,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                  ),
                  onPressed: () {
                    _searchController.updateSearchResults();
                  },
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
            )
          ],
        ),
      );
    });
  }

  Widget buildSearchViews(context) {
    return GetBuilder<SearchController>(builder: (_) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: FutureBuilder<List>(
            future: _searchController.searchResults,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return MyDialogBox("Error", snapshot.hasError);
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return snapshot.data?.length == 0
                  ? Center(child: Text("No Data Found"))
                  : ListView.builder(
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
    });
  }
}
