import 'package:get/get.dart';
import '../../controllers/animation_controller.dart';
import '../../controllers/bottom_navbar_controller.dart';
import '../../controllers/favourite_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/login_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/search_controller.dart';
import '../../controllers/signup_controller.dart';
import '../../controllers/splash_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => MyAnimationController());
  Get.lazyPut(() => SplashController());
  Get.lazyPut(() => SignupController());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => BottomNavbarController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => SearchController());
  Get.lazyPut(() => FavouriteController());
  Get.lazyPut(() => ProfileController());
}
