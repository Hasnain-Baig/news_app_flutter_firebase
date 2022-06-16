import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/components/containers/error_container.dart';
import 'package:news_app_flutter_hackathon/controllers/login_controller.dart';
import 'package:news_app_flutter_hackathon/screens/login.dart';

import '../../components/buttons/login_logout_button.dart';
import '../../components/buttons/my_switch.dart';
import '../../components/containers/news_container.dart';
import '../../controllers/bottom_navbar_controller.dart';
import '../../controllers/favourite_controller.dart';

class Favourite extends StatelessWidget {
  LoginController _loginController = Get.put(LoginController());
  // HomeController _homeController = Get.put(HomeController());
  FavouriteController _favController = Get.put(FavouriteController());
  BottomNavbarController _bottomNavbarController =
      Get.put(BottomNavbarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (_) {
      return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text("Favourites"),
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [MySwitch(), LoginOrLogoutButton()],
          ),
          body: GetBuilder<BottomNavbarController>(builder: (_) {
            return !_bottomNavbarController.activeCon
                ? MyErrorContainer("Internet Connection Error")
                : _loginController.userData["uid"] == null
                    // ? buildLoginFirstContainer(context)
                    ? MyErrorContainer(
                        "No favourites, You have to log in first!",
                      )
                    : Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            children: [buildFavouritesNewsContainer(context)],
                          ),
                        ),
                      );
          }));
    });
  }

  Widget buildLoginFirstContainer(context) {
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
              "No favourites, You have to log in first!",
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.to(Login());
                },
                child: Text("Log In"))
          ],
        ),
      ),
    );
  }

  Widget buildFavouritesNewsContainer(context) {
    // return GetBuilder<FavouriteController>(builder: (_) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _favController.favsStream,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map data = document.data() as Map;
                var userId = document.id;

                return userId == _loginController.userData['uid']
                    ? data['favourites'] == null ||
                            data['favourites'].length == 0
                        ? buildNoFavouritesContainer(context)
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data['favourites'].length,
                            itemBuilder: (context, index) {
                              Map favNewsData = data['favourites'][index];
                              return NewsContainer(favNewsData);
                            })
                    : SizedBox(
                        height: 0,
                      );
              }).toList(),
            );
          }),
    );
    // });
  }

  Widget buildNoFavouritesContainer(context) {
    return Center(
        child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              "No Favourites",
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
              ),
            )));
  }
}
