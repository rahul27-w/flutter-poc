import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nectar/constant/constant.dart';
import 'package:nectar/feature/feature_dashboard/view/dashboard_screen.dart';
import 'package:nectar/resources/colors.dart';
import 'package:nectar/resources/image_constant.dart';
import 'package:nectar/resources/text_styles.dart';
import 'package:nectar/utils/app_text.dart';
import 'package:nectar/utils/button_container.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorStyles.primaryColor,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(kWelcomeImage), fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Spacer(),
                icon(),
                SizedBox(height: kScreenHeight * 0.024),
                welcomeText(),
                SizedBox(height: kScreenHeight * 0.048),
                ButtonContainer(
                  buttonText: kGetStarted,
                  buttonWidth: kScreenWidth * 0.83,
                  buttonHeight: kScreenHeight * 0.06,
                  borderRadius: 10,
                  buttonColor: ColorStyles.primaryColor,
                  onTap: () => Get.offAll(() => DashboardScreen()),
                ),
                SizedBox(height: kScreenHeight * 0.048),
              ],
            ),
          ),
        ));
  }

  Widget welcomeText() {
    return Column(
      children: <Widget>[
        AppText(
            text: kWelcome,
            textAlign: TextAlign.center,
            textStyle: TextStyles.whiteBold48Text),
        AppText(
            text: kToStore,
            textAlign: TextAlign.center,
            textStyle: TextStyles.whiteBold48Text),
        SizedBox(height: kScreenHeight * 0.012),
        AppText(
            text: kGetGroceries,
            textAlign: TextAlign.center,
            textStyle: TextStyles.whiteRegular14Text),
      ],
    );
  }

  Widget icon() {
    return SvgPicture.asset(
      kLogoImage,
      width: 45,
      height: 45,
    );
  }
}
