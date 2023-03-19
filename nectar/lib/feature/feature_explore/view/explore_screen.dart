import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/constant/constant.dart';
import 'package:nectar/resources/colors.dart';
import 'package:nectar/resources/image_constant.dart';
import 'package:nectar/resources/text_styles.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerWidget(),

            ],
          ),
        ),
      ),
    );
  }

  Widget headerWidget() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: kScreenHeight * 0.018),
          Text(
            'Find Products',
            style: TextStyles.blackBold22Text,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Container(
              width: kScreenWidth,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorStyles.DarkGrey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      kSearchImage,
                    ),
                    SizedBox(width: 10),
                    Text(
                      kSearchStore,
                      style: TextStyles.greyBold18Text,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
