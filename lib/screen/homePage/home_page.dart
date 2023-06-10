// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nano/screen/cart/care_screen.dart';
import 'package:nano/screen/favourite/favourite_screen.dart';
import 'package:nano/screen/product/product_screen.dart';
import 'package:nano/screen/profile/profile_screen.dart';
import 'package:nano/utils/images.dart';
import 'package:nano/utils/theme_color.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatelessWidget {
  int? pageIndex = 0;

  HomePage({this.pageIndex});

  final ScrollController scrollController = ScrollController();

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const ProductScreen(),
      const CartScreen(),
      const FavouriteScreen(),
      const ProfileScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          inactiveIcon: SvgPicture.asset(
            Images.products,
            color: ColorsFave.inactiveColor,
          ),
          icon: SvgPicture.asset(
            Images.products,
            color: ColorsFave.primaryColor,
          )),
      PersistentBottomNavBarItem(
          inactiveIcon: SvgPicture.asset(
            Images.cart,
            color: ColorsFave.inactiveColor,
          ),
          icon: SvgPicture.asset(
            Images.cart,
            color: ColorsFave.primaryColor,
          )),
      PersistentBottomNavBarItem(
          inactiveIcon: SvgPicture.asset(
            Images.favourite,
            color: ColorsFave.inactiveColor,
          ),
          icon: SvgPicture.asset(
            Images.favourite,
            color: ColorsFave.primaryColor,
          )),
      PersistentBottomNavBarItem(
          inactiveIcon: SvgPicture.asset(
            Images.profile,
            color: ColorsFave.inactiveColor,
          ),
          icon: SvgPicture.asset(
            Images.profile,
            color: ColorsFave.primaryColor,
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsFave.backgroundPages,
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 0,
          toolbarHeight: 0,
          backgroundColor: ColorsFave.primaryColor,
        ),
        body: PersistentTabView(
          context,
          controller: _controller,
          onItemSelected: (index) {
            pageIndex = index;
          },
          navBarHeight: MediaQuery.of(context).size.height * 0.085,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          popAllScreensOnTapAnyTabs: false,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          popAllScreensOnTapOfSelectedTab: false,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: const NavBarDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22), topRight: Radius.circular(22)),
          ),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.simple,
        ));
  }
}
