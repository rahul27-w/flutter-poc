import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/constant/constant.dart';
import 'package:nectar/feature/feature_onboarding/view/welcome_screen.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    const delay = const Duration(seconds: 3);
    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    Get.to(() => WelcomeScreen());
  }

  void getScreenSize(BuildContext context) {
    kScreenHeight = MediaQuery.of(context).size.height;
    kScreenWidth = MediaQuery.of(context).size.width;
  }
}