import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter_hackathon/controllers/login_controller.dart';
import 'package:news_app_flutter_hackathon/screens/signup.dart';

import '../controllers/animation_controller.dart';

class Login extends StatelessWidget {
  LoginController _loginController = Get.put(LoginController());
  MyAnimationController _animationController = Get.put(MyAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: GetBuilder<MyAnimationController>(
          builder: (_) {
            return Container(
              width: MediaQuery.of(context).size.width * 1,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Theme.of(context).colorScheme.primary.withBlue(5),
                    Theme.of(context).colorScheme.primary.withBlue(5)
                  ])),
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    AnimatedOpacity(
                        opacity: _animationController.opacity,
                        duration: Duration(milliseconds: 500),
                        child: GetBuilder<LoginController>(
                          builder: (_) {
                            return buildLoginContainer(context);
                          },
                        )),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget buildLoginContainer(context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width * .8,
      // height: _animationController.height,
      curve: Curves.fastOutSlowIn,
      margin: EdgeInsets.all(_animationController.margin),
      // padding: AnimatedPadding(padding: padding, duration: duration),
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            buildMyTextButton(context, "Sign Up"),
            SizedBox(height: 40),
            Text("Log In", style: TextStyle(fontSize: 24)),
            SizedBox(height: 70),
            buildTextFieldContainer(context, "Email Address", false),
            SizedBox(height: 20),
            buildTextFieldContainer(context, "Pasword", true),
            SizedBox(height: 5),
            buildMyTextButton(context, "Forgot Password?"),
            SizedBox(height: 10),
            _loginController.isLoad
                ? CircularProgressIndicator()
                : buildMyRaisedButton(context, "Login"),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldContainer(context, String value, isPassword) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      height: 45,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: isPassword
            ? _loginController.passwordController
            : _loginController.emailController,
        obscureText: isPassword ? _loginController.hidePass : false,
        keyboardType:
            isPassword ? TextInputType.text : TextInputType.emailAddress,
        autofocus: !isPassword,
        cursorColor: Theme.of(context).colorScheme.onSecondary,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: value,
          hintStyle: TextStyle(fontSize: 16),
          prefixIcon: isPassword
              ? Icon(
                  Icons.password,
                  size: 20,
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.5),
                )
              : Icon(
                  Icons.email,
                  size: 20,
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.5),
                ),
          suffixIcon: isPassword
              ? (_loginController.hidePass
                  ? IconButton(
                      icon: Icon(
                        Icons.visibility,
                        size: 20,
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondary
                            .withOpacity(0.5),
                      ),
                      onPressed: () {
                        _loginController.hidePassword();
                      },
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.visibility_off,
                        size: 20,
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondary
                            .withOpacity(0.5),
                      ),
                      onPressed: () {
                        _loginController.hidePassword();
                      },
                    ))
              : Text(""),
        ),
      ),
    );
  }

  Widget buildMyTextButton(context, String val) {
    return TextButton(
        onPressed: () {},
        child: val == "Sign Up"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        "Dont have an account? ",
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(.7)),
                      ),
                      TextButton(
                        child: Text(
                          "${val}",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(1)),
                        ),
                        onPressed: () {
                          Get.to(Signup());
                        },
                      ),
                    ],
                  )
                ],
              )
            : Text(
                val,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.5),
                ),
              ));
  }

  Widget buildMyRaisedButton(context, String val) {
    return Container(
      width: MediaQuery.of(context).size.width * .3,
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textColor: Theme.of(context).colorScheme.onPrimary,
          color: Theme.of(context).colorScheme.primary.withBlue(5),
          splashColor: Theme.of(context).colorScheme.primary.withBlue(100),
          onPressed: () {
            _loginController.login(context);
          },
          child: Text(val)),
    );
  }
}
