import 'package:Betal/models/prayer_model.dart';

class PrayerDatabase {
  static PrayerModel prayerModel = PrayerModel();
  static List<PrayerModel> prayers = [];

  static Future<List<PrayerModel>> getAllData() async {
    prayers = [];
    prayers.add(PrayerModel(
        prayerName: 'Yousef moaty', prayerAudio: 'yousef_moaty.mp3'));
    prayers.add(PrayerModel(
        prayerName: 'Ahmed Alnafis', prayerAudio: 'ahmed_alnafis.mp3'));
    return prayers;
  }
}
