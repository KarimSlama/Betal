import 'package:Betal/models/month_model.dart';

import 'weekday_model.dart';

class Hijri {
  String? date;
  String? format;
  String? day;
  Weekday? weekday;
  Month? month;
  String? year;

  Hijri(
      {this.date, this.format, this.day, this.weekday, this.month, this.year});

  Hijri.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    format = json["format"];
    day = json["day"];
    weekday =
        json["weekday"] == null ? null : Weekday.fromJson(json["weekday"]);
    month = json["month"] == null ? null : Month.fromJson(json["month"]);
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
