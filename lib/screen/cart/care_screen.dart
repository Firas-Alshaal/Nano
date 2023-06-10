import 'package:flutter/material.dart';
import 'package:nano/utils/images.dart';
import 'package:nano/utils/theme_color.dart';
import 'package:nano/widget/material/appbar_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsFave.secondColor,
      appBar: CustomAppBar(title: 'Cart'),
      body: Center(
        child: Image.asset(Images.logo),
      ),
    );
  }
}
