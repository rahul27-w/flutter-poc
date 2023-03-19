import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nectar/constant/constant.dart';
import 'package:nectar/feature/feature_splash/controller/splash_controller.dart';
import 'package:nectar/resources/colors.dart';
import 'package:nectar/resources/image_constant.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    splashController.getScreenSize(context);
    return Scaffold(
      backgroundColor: ColorStyles.primaryColor,
      body: splashScreen(),
    );
  }

  Widget splashScreen() {
    String splashIcon = kSplashImage;
    return Center(
      child: SvgPicture.asset(splashIcon),
    );
  }
}
