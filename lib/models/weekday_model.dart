class Weekday {
  String? en;
  String? ar;

  Weekday({this.en, this.ar});

  Weekday.fromJson(Map<String, dynamic> json) {
    en = json["en"];
    ar = json["ar"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["en"] = en;
    _data["ar"] = ar;
    return _data;
  }
}