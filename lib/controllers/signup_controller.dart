import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/components/dialogBoxes/my_dialog_box.dart';

class SignupController extends GetxController {
  bool _hidePass = true;
  bool get hidePass => _hidePass;

  bool _hideConfPass = true;
  bool get hideConfPass => _hideConfPass;

  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  TextEditingController _confPasswordController = TextEditingController();
  TextEditingController get confPasswordController => _confPasswordController;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController get fullNameController => _fullNameController;

  TextEditingController _genderController = TextEditingController();
  TextEditingController get genderController => _genderController;

  TextEditingController _myDOBController = TextEditingController();
  TextEditingController get myDOBController => _myDOBController;

  TextEditingController _countryController = TextEditingController();
  TextEditingController get countryController => _countryController;

  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController get phoneNumController => _phoneNumController;

  String _phoneCode = "+92";
  String get phoneCode => _phoneCode;

  bool _isLoad = false;
  bool get isLoad => _isLoad;

  void onInit() {
    print("onint login controller------>");
    _countryController.text = "Pakistan";
  }

  hidePassword() {
    _hidePass = !_hidePass;
    update();
  }

  hideConfPassword() {
    _hideConfPass = !_hideConfPass;
    update();
  }

  setDOB(context) async {
    var initialDate = DateTime(DateTime.now().year - 10);
    var newDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year - 1),
      initialDate: initialDate,
      helpText: "SELECT DATE OF BIRTH",
    );
    if (newDate != null) {
      _myDOBController.text = "${newDate.day}/${newDate.month}/${newDate.year}";
    }
    update();
  }

  setGender(value) {
    _genderController.text = value;
    update();
  }

  setPhoneNumber(countryCode) {
    _phoneCode = countryCode;
    update();
  }

  signup(context) async {
    print("Signup");
    var fullName = _fullNameController.text;
    var email = _emailController.text;
    var password = _passwordController.text;
    var confPassword = _confPasswordController.text;
    var gender = _genderController.text;
    var dob = _myDOBController.text;
    var country = _countryController.text;
    var phone = _phoneCode + _phoneNumController.text;

    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    print(
        "Signup data--> ${fullName} , ${email} , ${password}, ${confPassword}, ${gender}, ${dob},${country}, ${phone}");
    if (fullName != "" &&
        gender != "" &&
        dob != "" &&
        country != "" &&
        phone != "" &&
        email != "" &&
        password != "") {
      print("----->${password}  ${confPassword}");
      if (password == confPassword) {
        try {
          _isLoad = true;
          update();

          UserCredential user = await auth.createUserWithEmailAndPassword(
              email: email, password: password);
          await db.collection("users").doc(user.user!.uid).set({
            "fullname": fullName,
            "gender": gender,
            "date of birth": dob,
            "country": country,
            "phone number": phone,
            "email": email,
            "password": password,
          });
          _isLoad = false;
          update();
          _fullNameController.clear();
          _genderController.clear();
          _countryController.clear();
          _myDOBController.clear();
          _emailController.clear();
          _phoneNumController.clear();
          _passwordController.clear();
          _confPasswordController.clear();

          Object e = "Signed Up Successfully";
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MyDialogBox("Success", e);
              });

          print("User Registered succesfully....");
        } catch (e) {
          _isLoad = false;
          update();
          Object e = "Internet Connection Error!";
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MyDialogBox("Error", e);
              });
        }
      } else {
        Object e = "Password and Confirm Password are not matched";
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyDialogBox("Error", e);
            });
      }
    } else {
      Object e = "Some fields are empty";
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialogBox("Error", e);
          });
    }

    update();
  }
}
