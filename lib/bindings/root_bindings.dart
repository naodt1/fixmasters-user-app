import 'package:fixmasters_user_app/controller/authController.dart';
import 'package:fixmasters_user_app/controller/bottom_nav_controller.dart';
import 'package:fixmasters_user_app/controller/handyman_controller.dart';
import 'package:fixmasters_user_app/controller/userController.dart';
import 'package:get/get.dart';

class RootBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(HandymanController());
    Get.put(BottomNavigationController());
    Get.put(AuthController());
  }

}