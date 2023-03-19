import 'package:flutter/material.dart';
import 'package:nectar/constant/constant.dart';
import 'package:nectar/resources/colors.dart';
import 'package:nectar/resources/text_styles.dart';

class GroceryFeaturedItem {
  final String name;
  final String imagePath;
  final Color color;

  GroceryFeaturedItem(this.name, this.imagePath, this.color);
}

var groceryFeaturedItem = [
  GroceryFeaturedItem("Pulses", "assets/images/pulses.png", Color(0xffF8A44C)),
  GroceryFeaturedItem("Rise", "assets/images/rise.png", ColorStyles.primaryColor),
];

class GrocerySliderCardWidget extends StatelessWidget {
  const GrocerySliderCardWidget(this.groceryFeaturedItem, this.index);

  final List<GroceryFeaturedItem> groceryFeaturedItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        height: kScreenHeight * 0.14,
        width: kScreenWidth * 0.63,
        decoration: BoxDecoration(
            color: groceryFeaturedItem[index].color.withOpacity(0.25),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image(
                image: AssetImage(groceryFeaturedItem[index].imagePath),
              ),
              Spacer(),
              Text(
                groceryFeaturedItem[index].name,
                style: TextStyles.blackBold24Text,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
