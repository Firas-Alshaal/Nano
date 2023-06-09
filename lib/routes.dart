import 'package:flutter/material.dart';
import 'package:nano/features/posts/presentation/pages/posts_page.dart';
import 'package:nano/utils/constant.dart';

class Routes {
  static const _splash = PostsPage();

  static final routes = <String, WidgetBuilder>{
    Constants.SPLASH: (BuildContext context) => _splash,
  };
}
