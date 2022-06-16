import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/animation_controller.dart';
import '../controllers/signup_controller.dart';
import 'login.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Signup extends StatelessWidget {
  MyAnimationController _animationController = Get.put(MyAnimationController());
  SignupController _signupController = Get.put(SignupController());

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
                        child: GetBuilder<SignupController>(builder: (_) {
                          return buildSignupContainer(context);
                        })),
                    // GetBuilder<SignupController>(builder: (_) {
                    //   return buildMyTextButton(context, "Log In");
                    // })
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget buildSignupContainer(context) {
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
            buildMyTextButton(context, "Log In"),
            SizedBox(height: 30),
            Text("Sign Up", style: TextStyle(fontSize: 24)),
            SizedBox(height: 50),
            buildTextFieldContainer(context, "Full Name", false),
            SizedBox(height: 20),
            buildTextFieldContainer(context, "Date Of Birth", false),
            SizedBox(height: 20),
            buildTextFieldContainer(context, "Gender", false),
            SizedBox(height: 20),
            buildTextFieldContainer(context, "Country", false),
            SizedBox(height: 20),
            buildTextFieldContainer(context, "Email Address", false),
            SizedBox(height: 20),
            buildTextFieldContainer(context, "Phone Number", false),
            SizedBox(height: 20),
            buildTextFieldContainer(context, "Password", true),
            SizedBox(height: 20),
            buildTextFieldContainer(context, "Confirm Password", true),
            SizedBox(height: 10),
            _signupController.isLoad
                ? CircularProgressIndicator()
                : buildMyRaisedButton(context, "Sign Up"),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldContainer(context, String value, isPassword) {
    return Container(
        width: MediaQuery.of(context).size.width * .7,
        // height: 45,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: value == "Gender"
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text("   ${value}"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                          activeColor: Theme.of(context).colorScheme.primary,
                          value: 'male',
                          groupValue: _signupController.genderController.text,
                          onChanged: (val) {
                            _signupController.setGender(val.toString());
                          }),
                      Text("Male"),
                      Radio(
                          activeColor: Theme.of(context).colorScheme.primary,
                          value: 'female',
                          groupValue: _signupController.genderController.text,
                          onChanged: (val) {
                            _signupController.setGender(val.toString());
                          }),
                      Text("Female"),
                      Radio(
                          activeColor: Theme.of(context).colorScheme.primary,
                          value: 'other',
                          groupValue: _signupController.genderController.text,
                          onChanged: (val) {
                            _signupController.setGender(val.toString());
                          }),
                      Text("Other"),
                    ],
                  )
                ],
              )
            : TextField(
                controller: value == "Password"
                    ? _signupController.passwordController
                    : value == "Confirm Password"
                        ? _signupController.confPasswordController
                        : value == "Email Address"
                            ? _signupController.emailController
                            : value == "Full Name"
                                ? _signupController.fullNameController
                                : value == "Country"
                                    ? _signupController.countryController
                                    : value == "Phone Number"
                                        ? _signupController.phoneNumController
                                        : _signupController.myDOBController,

                obscureText: isPassword
                    ? value == "Password"
                        ? _signupController.hidePass
                        : _signupController.hideConfPass
                    : false,
                keyboardType: value == "Phone Number"
                    ? TextInputType.number
                    : !isPassword
                        ? TextInputType.emailAddress
                        : TextInputType.text,
                autofocus: false,
                // !isPassword,
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
                      : value == "Email Address"
                          ? Icon(
                              Icons.email,
                              size: 20,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(0.5),
                            )
                          : value == "Full Name"
                              ? Icon(
                                  Icons.account_circle,
                                  size: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary
                                      .withOpacity(0.5),
                                )
                              : value == "Country"
                                  ? CountryCodePicker(
                                      initialSelection: 'Pakistan',
                                      alignLeft: true,
                                      showCountryOnly: true,
                                      showOnlyCountryWhenClosed: true,
                                      showFlag: true,
                                      onChanged: (country) {
                                        _signupController.countryController
                                            .text = country.name.toString();
                                      },
                                      searchDecoration: InputDecoration(
                                          filled: true,
                                          fillColor: Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                              .withOpacity(.1),
                                          border: InputBorder.none,
                                          hintText: " Select Country",
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                                .withOpacity(.7),
                                          )),
                                    )
                                  : value == "Phone Number"
                                      ? CountryCodePicker(
                                          initialSelection: "+92",
                                          showFlag: true,
                                          onChanged: (countryCode) {
                                            _signupController.setPhoneNumber(
                                                countryCode.toString());
                                          },
                                          // onInit: (countryCode) {
                                          //   _signupController.setPhoneNumber(
                                          //       countryCode.toString());
                                          // },
                                          searchDecoration: InputDecoration(
                                              hintText: "Select Country Code",
                                              filled: true,
                                              fillColor: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary
                                                  .withOpacity(.1),
                                              border: InputBorder.none,
                                              prefixIcon: Icon(
                                                Icons.search,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary
                                                    .withOpacity(.7),
                                              )),
                                        )
                                      : value == "Date Of Birth"
                                          ? IconButton(
                                              icon: Icon(
                                                Icons.calendar_month,
                                                size: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary
                                                    .withOpacity(0.5),
                                              ),
                                              onPressed: () {
                                                _signupController
                                                    .setDOB(context);
                                              },
                                            )
                                          : Text(""),
                  suffixIcon: (isPassword)
                      ? value == "Password"
                          ? IconButton(
                              icon: Icon(
                                _signupController.hidePass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(0.5),
                              ),
                              onPressed: () {
                                _signupController.hidePassword();
                              },
                            )
                          : IconButton(
                              icon: Icon(
                                _signupController.hideConfPass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(0.5),
                              ),
                              onPressed: () {
                                _signupController.hideConfPassword();
                              },
                            )
                      : Text(""),
                ),
              ));
  }

  Widget buildMyTextButton(context, String val) {
    return TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Text(
                  "Already have an account?",
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
                    Get.to(Login());
                  },
                ),
              ],
            )
          ],
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
            _signupController.signup(context);
          },
          child: Text(val)),
    );
  }
}
