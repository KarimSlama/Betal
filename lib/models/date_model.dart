import 'package:Betal/models/gregorian_model.dart';
import 'package:Betal/models/hijri_model.dart';

class Date {
  String? readable;
  String? timestamp;
  Hijri? hijri;
  Gregorian? gregorian;

  Date({this.readable, this.timestamp, this.hijri, this.gregorian});

  Date.fromJson(Map<String, dynamic> json) {
    readable = json['readable'];
    timestamp = json['timestamp'];
    hijri = json['hijri'] != null ? Hijri.fromJson(json['hijri']) : null;
    gregorian = json['gregorian'] != null
        ? Gregorian.fromJson(json['gregorian'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['readable'] = readable;
    data['timestamp'] = timestamp;
    if (hijri != null) {
      data['hijri'] = hijri!.toJson();
    }
    if (gregorian != null) {
      data['gregorian'] = gregorian!.toJson();
    }
    return data;
  }
}
