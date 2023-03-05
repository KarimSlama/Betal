import 'package:Betal/models/month_model.dart';
import 'package:Betal/models/weekday_model.dart';

class Gregorian {
  String? date;
  String? format;
  String? day;
  GregorianWeekday? weekday;
  GregorianMonth? month;
  String? year;

  Gregorian(
      {this.date, this.format, this.day, this.weekday, this.month, this.year});

  Gregorian.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    format = json["format"];
    day = json["day"];
    weekday = json["weekday"] == null
        ? null
        : GregorianWeekday.fromJson(json["weekday"]);
    month =
    json["month"] == null ? null : GregorianMonth.fromJson(json["month"]);
    year = json["year"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["date"] = date;
    _data["format"] = format;
    _data["day"] = day;
    if (weekday != null) {
      _data["weekday"] = weekday?.toJson();
    }
    if (month != null) {
      _data["month"] = month?.toJson();
    }
    _data["year"] = year;
    return _data;
  }
}

class GregorianWeekday {
  String? en;

  GregorianWeekday({this.en});

  GregorianWeekday.fromJson(Map<String, dynamic> json) {
    en = json["en"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["en"] = en;
    return _data;
  }
}

class GregorianMonth {
  int? number;
  String? en;

  GregorianMonth({this.number, this.en});

  GregorianMonth.fromJson(Map<String, dynamic> json) {
    number = json["number"];
    en = json["en"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["number"] = number;
    _data["en"] = en;
    return _data;
  }
}