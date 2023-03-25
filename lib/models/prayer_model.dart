class PrayerModel {
  String? prayerName;
  String? prayerAudio;

  PrayerModel({this.prayerName, this.prayerAudio});

  factory PrayerModel.fromJson(Map<String, dynamic> json) {
    return PrayerModel(
      prayerName: json["prayerName"],
      prayerAudio: json["prayerAudio"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "prayerName": prayerName,
      "prayerAudio": prayerAudio,
    };
  }
}
