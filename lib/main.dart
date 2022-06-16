// apiKey=9d92b77ad3da46339185a14972111be0
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/controllers/theme_controller.dart';

import 'components/Themes/my_theme.dart';
import 'components/config/firebase_options.dart';
import 'screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await controllers.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (_) {
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: currentTheme.currentMode,
          home: SplashScreen());
    });
  }
}
