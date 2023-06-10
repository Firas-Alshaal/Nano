import 'package:flutter/material.dart';
import 'package:nano/utils/theme_color.dart';

class ProductDetailsIconWidget extends StatelessWidget {
  final IconData iconData;

  const ProductDetailsIconWidget({Key? key, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Center(
          child: Icon(
        iconData,
        color: ColorsFave.navyBlue,
      )),
    );
  }
}
