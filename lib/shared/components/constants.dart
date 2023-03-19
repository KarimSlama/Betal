import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

const green = Color(0xff5AE52A);
const bottomIndicator = Color(0xffb69f69);
const azanBoxColor = Color(0xffa6adc9);

var city;
var country;

var latitude;
var longitude;

var selectedCurrentLanguage;
var selectedSound;
var selectedNotificationStatus;
var currentDate = DateTime.now();
var currentTimeFormatted = DateFormat('HH:mm').format(currentDate);
var selectedHijriDay = HijriCalendar.now();

String getOS() {
  return Platform.operatingSystem;
}
