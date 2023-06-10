import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void alertFromApiFailure(context, String text) {
  Flushbar(
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.BOTTOM,
    messageText: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    ),
    duration: const Duration(seconds: 2),
    icon: const Icon(
      Icons.highlight_remove,
      color: Colors.red,
    ),
    backgroundColor: HexColor('#303030'),
    leftBarIndicatorColor: Colors.red[300],
  ).show(context);
}
