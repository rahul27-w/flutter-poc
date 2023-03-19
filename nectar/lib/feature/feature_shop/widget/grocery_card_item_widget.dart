import 'package:flutter/material.dart';
import 'package:nectar/constant/constant.dart';
import 'package:nectar/data/grocery_item.dart';
import 'package:nectar/resources/colors.dart';
import 'package:nectar/resources/text_styles.dart';

class GroceryItemCardWidget extends StatelessWidget {
  final List<GroceryItem> items;
  final int index;
  final VoidCallback addToCart;

  const GroceryItemCardWidget(
      {Key? key,
      required this.items,
      required this.index,
      required this.addToCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        width: kScreenWidth * 0.44,
        height: kScreenHeight * 0.31,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(child: Image.asset(items[index].imagePath))),
              Text(
                items[index].name,
                style: TextStyles.blackBold16Text,
              ),
              Text(
                items[index].description,
                style: TextStyles.greyRegular12Text,
              ),
              SizedBox(height: kScreenHeight * 0.024),
              Row(
                children: [
                  Text(
                    '\$${items[index].price.toString()}',
                    style: TextStyles.blackBold18Text,
                  ),
                  Spacer(),
                  InkResponse(
                    onTap: () => addToCart,
                    radius: 25,
                    child: Container(
                      width: kScreenWidth * 0.10,
                      height: kScreenHeight * 0.049,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: ColorStyles.primaryColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
