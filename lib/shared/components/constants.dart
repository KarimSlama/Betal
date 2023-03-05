import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const green = Color(0xff5AE52A);
const bottomIndicator = Color(0xffb69f69);
const azanBoxColor = Color(0xffa6adc9);

var city;
var country;
var selectedLanguage;

var currentDate = DateTime.now();
var currentTimeFormatted = DateFormat('HH:mm').format(currentDate);
