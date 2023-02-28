import 'package:flutter/material.dart';

import 'constants.dart';

void navigateTo(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false);
}

Widget divider() => Container(
    height: 1,
    width: 300.0,
    color: (currentDate.timeZoneOffset.inHours > 5 && currentDate.hour >= 20)
        ? const Color(0xffa6adc9)
        : const Color(0xffa6adc9).withOpacity(.2));
