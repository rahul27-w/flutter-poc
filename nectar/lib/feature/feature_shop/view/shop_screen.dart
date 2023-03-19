import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar/constant/constant.dart';
import 'package:nectar/data/grocery_item.dart';
import 'package:nectar/feature/feature_shop/widget/grocery_card_item_widget.dart';
import 'package:nectar/feature/feature_shop/widget/grocery_slider_card_widget.dart';
import 'package:nectar/resources/colors.dart';
import 'package:nectar/resources/image_constant.dart';
import 'package:nectar/resources/text_styles.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: kScreenHeight * 0.018),
              SvgPicture.asset(kLogoColorImage),
              SizedBox(height: kScreenHeight * 0.009),
              padded(headerWidget()),
              padded(searchBarWidget()),
              padded(homeBanner()),
              SizedBox(height: kScreenHeight * 0.031),
              padded(subTitles(kExclusiveOrder)),
              getHorizontalItemSlider(groceries, () {}),
              SizedBox(height: kScreenHeight * 0.018),
              padded(subTitles(kBestSelling)),
              getHorizontalItemSlider(bestSelling, () {}),
              SizedBox(height: kScreenHeight * 0.018),
              padded(subTitles(kGroceries)),
              SizedBox(height: kScreenHeight * 0.018),
              getGroceryItemSlider(groceryFeaturedItem),
              SizedBox(height: kScreenHeight * 0.018),
              getHorizontalItemSlider(groceries, () {}),
            ],
          ),
        ),
      ),
    ));
  }

  Widget getGroceryItemSlider(List<GroceryFeaturedItem> groceryFeaturedItem) {
    return Container(
              height: kScreenHeight * 0.14,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GrocerySliderCardWidget(groceryFeaturedItem, index);
                  }),
            );
  }

  Widget getHorizontalItemSlider(
      List<GroceryItem> items, VoidCallback addToCart) {
    return Container(
      height: kScreenHeight * 0.31,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GroceryItemCardWidget(
              index: index,
              items: items,
              addToCart: addToCart,
            );
          }),
    );
  }

  Row subTitles(String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyles.blackBold22Text,
        ),
        Spacer(),
        Text(
          kSeeAll,
          style: TextStyles.greenBold18Text,
        )
      ],
    );
  }

  Widget homeBanner() {
    return Container(
      width: kScreenWidth,
      height: kScreenHeight * 0.14,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kBannerBackgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Image.asset(kBannerImage),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kFreshVegetable,
                style: TextStyles.blackBold22Text,
              ),
              Text(
                kDiscount40,
                style: TextStyles.greenRegular16Text,
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget searchBarWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
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
    );
  }

  Widget headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(kLocationImage),
        SizedBox(width: kScreenWidth * 0.012),
        Text(
          kLocation,
          style: TextStyles.blackBold16Text,
        ),
      ],
    );
  }
}
