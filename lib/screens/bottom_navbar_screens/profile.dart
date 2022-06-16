import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/controllers/profile_controller.dart';

import '../../components/buttons/login_logout_button.dart';
import '../../components/buttons/my_switch.dart';
import '../../controllers/login_controller.dart';

class Profile extends StatelessWidget {
  ProfileController _profileController = Get.put(ProfileController());
  LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: Icon(Icons.menu),
          title: Text("Profile"),
          actions: [MySwitch(), LoginOrLogoutButton()],
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                buildProfileHeader(context),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(.1),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      buildProfileInfoListTiles(
                        context,
                        true,
                        "",
                        "",
                      ),
                      Divider(
                        thickness: 3,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      buildProfileInfoListTiles(context, false, "Account Id",
                          "${_loginController.userData['uid']}"),
                      buildProfileInfoListTiles(context, false, "Gender",
                          "${_loginController.userData['gender']}"),
                      buildProfileInfoListTiles(context, false, "Date of Birth",
                          "${_loginController.userData['date of birth']}"),
                      buildProfileInfoListTiles(context, false, "Country",
                          "${_loginController.userData['country']}"),
                      buildProfileInfoListTiles(context, false, "Email Address",
                          "${_loginController.userData['email']}"),
                      buildProfileInfoListTiles(context, false, "Phone Number",
                          "${_loginController.userData['phone number']}"),
                    ],
                  ),
                ),
              ],
            )),
      );
    });
  }

  Widget buildProfileHeader(context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(.1),
          ),
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _profileController.openlogoutDialog(context);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        _loginController.userData['fullname']
                            .toString()
                            .toUpperCase()
                            .characters
                            .first,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ]),
            SizedBox(height: 10),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("assets/images/cr7.jpg"),
            ),
            SizedBox(height: 20),
            Text(
              "${_loginController.userData['fullname'].toString().toUpperCase()}",
              style: TextStyle(fontSize: 20),
            )
          ]));
    });
  }

  Widget buildProfileInfoListTiles(context, isHeader, title, subtitle) {
    return !isHeader
        ? ListTile(
            leading: Icon(
              title == "Account Id"
                  ? Icons.verified_user_outlined
                  : title == "Date of Birth"
                      ? Icons.calendar_month
                      : title == "Country"
                          ? Icons.flag_outlined
                          : title == "Email Address"
                              ? Icons.email
                              : title == "Phone Number"
                                  ? Icons.phone
                                  : title == "Gender" && subtitle == "male"
                                      ? Icons.male
                                      : title == "Gender" &&
                                              subtitle == "female"
                                          ? Icons.female
                                          : Icons.add,
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
              size: 24,
            ),
            title: Text(title,
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
                  fontWeight: FontWeight.w500,
                )),
            horizontalTitleGap: 5,
            subtitle: Text(subtitle,
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
                )),
          )
        : ListTile(
            title: Text("Account Details",
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSecondary.withOpacity(.9),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                )),
          );
  }
}
