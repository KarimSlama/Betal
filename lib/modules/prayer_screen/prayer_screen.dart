import 'dart:async';
import 'package:Betal/notification_model.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/cubit/mode_cubit.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrayerScreen extends StatefulWidget {
  PrayerScreen({Key? key}) : super(key: key);

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  var fajr;
  var sunrise;
  var dhuhr;
  var asr;
  var maghrib;
  var isha;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        var prayer = MainCubit.getContext(context).prayerDataModel;
        TimeOfDay stringToTimeOfDay(String time) {
          final format = DateFormat.Hm();
          return TimeOfDay.fromDateTime(format.parse(time));
        }

        fajr = stringToTimeOfDay(prayer!.data!.timings!.fajr!);
        sunrise = stringToTimeOfDay(prayer.data!.timings!.sunrise!);
        dhuhr = stringToTimeOfDay(prayer.data!.timings!.dhuhr!);
        asr = stringToTimeOfDay(prayer.data!.timings!.asr!);
        maghrib = stringToTimeOfDay(prayer.data!.timings!.maghrib!);
        isha = stringToTimeOfDay(prayer.data!.timings!.isha!);

        List<TimeOfDay> prayerTimesTiming = [
          stringToTimeOfDay(prayer.data!.timings!.fajr!),
          stringToTimeOfDay(prayer.data!.timings!.sunrise!),
          stringToTimeOfDay(prayer.data!.timings!.dhuhr!),
          stringToTimeOfDay(prayer.data!.timings!.asr!),
          stringToTimeOfDay(prayer.data!.timings!.maghrib!),
          stringToTimeOfDay(prayer.data!.timings!.isha!),
        ];

        List<DateTime> prayerTimes = [];
        DateTime now = DateTime.now();
        for (int i = 0; i < prayerTimesTiming.length; i++) {
          DateTime prayerTime = DateTime(now.year, now.month, now.day,
              prayerTimesTiming[i].hour, prayerTimesTiming[i].minute);
          prayerTimes.add(prayerTime);
        }

        DateTime upcomingPrayerTime(
            DateTime currentDate, List<DateTime> prayerTimes) {
          for (int i = 0; i < prayerTimes.length; i++) {
            if (currentDate.isBefore(prayerTimes[i])) {
              return prayerTimes[i];
            }
          }
          // If the current time is after the last prayer time, return the next day's Fajr time
          return prayerTimes[0].add(const Duration(days: 1));
        }

        NotificationService.showNotification(
          title: '$upcomingLevelPrayer prayer',
          body: '$upcomingLevelPrayer prayer time is coming',
          flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
          time: upcomingPrayerTime(currentDate, prayerTimes),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60.0,
              ),
              Text(
                'UPCOMING'.tr,
                style: TextStyle(
                    color: (currentDate.hour >= 20 || currentDate.hour <= 5)
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16.0,
              ),
              if (currentDate.hour > isha.hour ||
                  currentDate.hour <= fajr.hour) ...[
                Text(
                  'Fajr'.tr,
                  style: TextStyle(
                      color: (currentDate.hour >= 20 || currentDate.hour <= 5)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ] else if (currentDate.hour >= fajr.hour &&
                      currentDate.hour < dhuhr.hour ||
                  currentDate.minute <= dhuhr.minute) ...[
                Text('Dhuhr'.tr,
                    style: TextStyle(
                        color: (currentDate.hour >= 20 || currentDate.hour <= 5)
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500))
              ] else if (currentDate.hour >= dhuhr.hour &&
                  currentDate.hour <= asr.hour &&
                  currentDate.minute <= asr.minute) ...[
                Text('Asr'.tr,
                    style: TextStyle(
                        color: (currentDate.hour >= 20 || currentDate.hour <= 5)
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ] else if (currentDate.hour >= asr.hour &&
                      currentDate.hour <= maghrib.hour ||
                  currentDate.minute <= maghrib.minute) ...[
                Text(
                  'Maghrib'.tr,
                  style: TextStyle(
                      color: (currentDate.hour >= 20 || currentDate.hour <= 5)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ] else if (currentDate.hour >= maghrib.hour &&
                  currentDate.hour <= isha.hour &&
                  currentDate.minute <= isha.minute) ...[
                Text(
                  'Isha'.tr,
                  style: TextStyle(
                      color: (currentDate.hour >= 20 || currentDate.hour <= 5)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ],
              const SizedBox(
                height: 16.0,
              ),
              if (currentDate.hour > isha.hour ||
                  currentDate.hour <= fajr.hour) ...[
                Text(
                  '${prayer.data?.timings?.fajr}',
                  style: TextStyle(
                      color: (currentDate.hour >= 20 || currentDate.hour <= 5)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ] else if (currentDate.hour >= fajr.hour &&
                      currentDate.hour < dhuhr.hour ||
                  currentDate.minute <= dhuhr.minute) ...[
                Text('${prayer.data?.timings?.dhuhr}',
                    style: TextStyle(
                        color: (currentDate.hour >= 20 || currentDate.hour <= 5)
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500))
              ] else if (currentDate.hour >= dhuhr.hour &&
                  currentDate.hour <= asr.hour &&
                  currentDate.minute <= asr.minute) ...[
                Text('${prayer.data?.timings?.asr}',
                    style: TextStyle(
                        color: (currentDate.hour >= 20 || currentDate.hour <= 5)
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ] else if (currentDate.hour >= asr.hour &&
                      currentDate.hour <= maghrib.hour ||
                  currentDate.minute <= maghrib.minute) ...[
                Text(
                  '${prayer.data?.timings?.maghrib}',
                  style: TextStyle(
                      color: (currentDate.hour >= 20 || currentDate.hour <= 5)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ] else if (currentDate.hour >= maghrib.hour &&
                  currentDate.hour <= isha.hour &&
                  currentDate.minute <= isha.minute) ...[
                Text(
                  '${prayer.data?.timings?.isha}',
                  style: TextStyle(
                      color: (currentDate.hour >= 20 || currentDate.hour <= 5)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ],
              const SizedBox(
                height: 50.0,
              ),
              Container(
                padding: const EdgeInsetsDirectional.only(
                    top: 10, start: 16, end: 16),
                height: 340.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(30.0),
                  color: ModeCubit.getContext(context).isDark == true
                      ? (currentDate.hour >= 20 && currentDate.hour <= 5 ||
                              currentDate.timeZoneOffset.inHours <= 5)
                          ? Colors.white
                          : azanBoxColor.withOpacity(.6)
                      : Colors.black.withOpacity(.5),
                ),
                child: buildPrayerList(context),
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget buildTime(context) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final hours = twoDigits(duration.inHours);
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   final seconds = twoDigits(duration.inSeconds.remainder(60));
  //   return Text(
  //     '$hours hr:$minutes min:$seconds sec'.tr,
  //     style: TextStyle(
  //       fontSize: 20.0,
  //       color: (currentDate.hour >= 20 || currentDate.hour <= 5)
  //           ? Colors.white
  //           : Colors.black,
  //     ),
  //   );
  // }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Widget buildPrayerList(context) => DefaultTextStyle(
        style: TextStyle(
          fontSize: 16.0,
          color: ModeCubit.getContext(context).isDark == true
              ? Colors.black
              : Colors.white.withOpacity(.7),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Container(
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: green.withOpacity(.4),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_active,
                        color: green,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    'Fajr'.tr,
                  ),
                  const Spacer(),
                  Text(
                    '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.fajr}',
                  ),
                ],
              ),
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: azanBoxColor.withOpacity(.4),
                    child: IconButton(
                      color: (currentDate.timeZoneOffset.inHours < 5 &&
                              currentDate.hour > 20)
                          ? Colors.grey.withOpacity(.8)
                          : azanBoxColor,
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_off),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    'Sunrise'.tr,
                  ),
                  const Spacer(),
                  Text(
                    '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.sunrise}',
                  ),
                ],
              ),
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: green.withOpacity(.4),
                    child: IconButton(
                      color: green,
                      onPressed: () {
                        //   NotificationModel.showNotification(
                        //       title: 'dhuhur test',
                        //       body: 'first notification sent got it?',
                        //       prayer: 'dhuhur test',
                        //       flutterLocalNotificationsPlugin:
                        //           flutterLocalNotificationsPlugin);
                      },
                      icon: const Icon(Icons.notifications_active_rounded),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    'Dhuhr'.tr,
                  ),
                  const Spacer(),
                  Text(
                    '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.dhuhr}',
                  ),
                ],
              ),
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: green.withOpacity(.4),
                    child: IconButton(
                      color: green,
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_active_rounded),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    'Asr'.tr,
                  ),
                  const Spacer(),
                  Text(
                    '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.asr}',
                  ),
                ],
              ),
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: green.withOpacity(.4),
                    child: IconButton(
                      color: green,
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_active_rounded),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    'Maghrib'.tr,
                  ),
                  const Spacer(),
                  Text(
                    '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.maghrib}',
                  ),
                ],
              ),
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: green.withOpacity(.4),
                    child: IconButton(
                      color: green,
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_active_rounded),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    'Isha'.tr,
                  ),
                  const Spacer(),
                  Text(
                    '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.isha}',
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  var upcomingLevelPrayer;

  String upcomingPrayer() {
    if (currentDate.hour == fajr!.hour) {
      return upcomingLevelPrayer = 'Fajr';
    } else if (currentDate.hour == dhuhr!.hour &&
        currentDate.timeZoneOffset.inHours == dhuhr!.hourOfPeriod) {
      return upcomingLevelPrayer = 'Dhuhr';
    } else if (currentDate.hour == asr!.hour &&
        currentDate.timeZoneOffset.inHours == asr!.hourOfPeriod) {
      return upcomingLevelPrayer = 'Asr';
    } else if (currentDate.hour == maghrib!.hour &&
        currentDate.timeZoneOffset.inHours == maghrib!.hourOfPeriod) {
      return upcomingLevelPrayer = 'Maghrib';
    } else if (currentDate.hour == isha!.hour &&
        currentDate.timeZoneOffset.inHours == isha!.hourOfPeriod) {
      return upcomingLevelPrayer = 'Isha';
    }
    return upcomingLevelPrayer;
  }

  @override
  void initState() {
    super.initState();
  }

// DateTime upcomingPrayerTime() {
//   if (currentDate.hour == fajr!.hour && currentDate.minute == fajr!.minute) {
//     return comingTime = fajr!;
//   } else if (currentDate.hour == dhuhr!.hour &&
//       currentDate.minute == dhuhr!.minute) {
//     return comingTime = dhuhr!;
//   } else if (currentDate.hour == asr!.hour &&
//       currentDate.minute == asr!.minute) {
//     return comingTime = asr!;
//   } else if (currentDate.hour == maghrib!.hour &&
//       currentDate.minute == maghrib!.minute) {
//     return comingTime = maghrib!;
//   } else if (currentDate.hour == isha!.hour &&
//       currentDate.minute == isha!.minute) {
//     return comingTime = isha!;
//   }
//   return comingTime;
// }

// Timer? timer;
//
// bool isCountDown = true;
// static const countDownDuration = Duration(hours: 2, minutes: 0);
// Duration duration = const Duration();
//
// void startTimer() {
//   setState(() {
//     timer = Timer.periodic(
//       const Duration(seconds: 1),
//       (timer) => minusTime(),
//     );
//   });
// }
//
// void minusTime() {
//   setState(() {
//     const addSeconds = 1;
//     final seconds = duration.inSeconds - addSeconds;
//     if (seconds > 0) {
//       duration = Duration(seconds: seconds);
//     } else {
//       timer?.cancel();
//     }
//   });
// }
//
// void reset() {
//   if (isCountDown) {
//     setState(() => duration = countDownDuration);
//   } else {
//     setState(() => duration = const Duration());
//   }
// }
}
