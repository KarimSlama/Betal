import 'package:Betal/notification_model.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/cubit/mode_cubit.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        var prayer = MainCubit
            .getContext(context)
            .prayerDataModel;
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

        List<String> prayersList = [
          prayer.data!.timings!.fajr!,
          prayer.data!.timings!.sunrise!,
          prayer.data!.timings!.dhuhr!,
          prayer.data!.timings!.asr!,
          prayer.data!.timings!.maghrib!,
          prayer.data!.timings!.isha!,
        ];

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

        DateTime upcomingPrayerTime(DateTime currentDate,
            List<DateTime> prayerTimes) {
          for (int i = 0; i < prayerTimes.length; i++) {
            if (currentDate.isAtSameMomentAs(prayerTimes[i])) {
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

        var currentPrayer;
        var currentPrayerTime;

        // if (currentDate.hour > isha.hour || currentDate.hour <= fajr.hour) {
        //   currentPrayer = 'Fajr'.tr;
        //   currentPrayerTime = prayer.data?.timings?.fajr;
        // } else if (currentDate.hour >= fajr.hour &&
        //         currentDate.hour < dhuhr.hour ||
        //     currentDate.minute <= dhuhr.minute) {
        //   currentPrayer = 'Dhuhr'.tr;
        //   currentPrayerTime = prayer.data?.timings?.dhuhr;
        // } else if (currentDate.hour >= dhuhr.hour &&
        //         currentDate.hour <= asr.hour ||
        //     currentDate.minute <= asr.minute) {
        //   currentPrayer = 'Asr'.tr;
        //   currentPrayerTime = prayer.data?.timings?.asr;
        // } else if (currentDate.hour >= asr.hour &&
        //         currentDate.hour <= maghrib.hour ||
        //     currentDate.minute <= maghrib.minute) {
        //   currentPrayer = 'Maghrib'.tr;
        //   currentPrayerTime = prayer.data?.timings?.maghrib;
        // } else if (currentDate.hour >= maghrib.hour &&
        //     currentDate.hour <= isha.hour &&
        //     currentDate.minute <= isha.minute) {
        //   currentPrayer = 'Isha'.tr;
        //   currentPrayerTime = prayer.data?.timings?.isha;
        // }

        // if (currentDate.hour > isha.hour || currentDate.hour <= fajr.hour) {
        //   currentPrayer = 'Fajr'.tr;
        //   currentPrayerTime = prayer.data?.timings?.fajr;
        // } else if (currentDate.hour >= fajr.hour &&
        //         currentDate.hour < dhuhr.hour ||
        //     currentDate.minute <= dhuhr.minute) {
        //   currentPrayer = 'Dhuhr'.tr;
        //   currentPrayerTime = prayer.data?.timings?.dhuhr;
        // } else if (currentDate.hour >= dhuhr.hour &&
        //         currentDate.hour <= asr.hour ||
        //     currentDate.minute <= asr.minute) {
        //   currentPrayer = 'Asr'.tr;
        //   currentPrayerTime = prayer.data?.timings?.asr;
        // } else if (currentDate.hour >= asr.hour &&
        //         currentDate.hour <= maghrib.hour ||
        //     currentDate.minute <= maghrib.minute) {
        //     currentPrayer = 'Maghrib'.tr;
        //     currentPrayerTime = prayer.data?.timings?.maghrib;
        // } else if (currentDate.hour >= maghrib.hour &&
        //     currentDate.hour <= isha.hour &&
        //     currentDate.minute <= isha.minute) {
        //     currentPrayer = 'Isha'.tr;
        //   currentPrayerTime = prayer.data?.timings?.isha;
        // }

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
                  fontWeight: FontWeight.w500,
                ),
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
              ] else
                if (currentDate.hour >= fajr.hour &&
                    currentDate.hour < dhuhr.hour ||
                    currentDate.minute <= dhuhr.minute) ...[
                  Text('Dhuhr'.tr,
                      style: TextStyle(
                          color: (currentDate.hour >= 20 ||
                              currentDate.hour <= 5)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500))
                ] else
                  if (currentDate.hour >= dhuhr.hour &&
                      currentDate.hour <= asr.hour ||
                      currentDate.minute <= asr.minute) ...[
                    Text('Asr'.tr,
                        style: TextStyle(
                            color: (currentDate.hour >= 20 ||
                                currentDate.hour <= 5)
                                ? Colors.white
                                : Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500)),
                  ] else
                    if (currentDate.hour >= asr.hour &&
                        currentDate.hour <= maghrib.hour ||
                        currentDate.minute <= maghrib.minute) ...[
                      Text(
                        'Maghrib'.tr,
                        style: TextStyle(
                            color: (currentDate.hour >= 20 || currentDate
                                .hour <= 5)
                                ? Colors.white
                                : Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ] else
                      if (currentDate.hour >= maghrib.hour &&
                          currentDate.hour <= isha.hour &&
                          currentDate.minute <= isha.minute) ...[
                        Text(
                          'Isha'.tr,
                          style: TextStyle(
                              color: (currentDate.hour >= 20 ||
                                  currentDate.hour <= 5)
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
              const SizedBox(
                height: 16,
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
              ] else
                if (currentDate.hour >= fajr.hour &&
                    currentDate.hour < dhuhr.hour ||
                    currentDate.minute <= dhuhr.minute) ...[
                  Text('${prayer.data?.timings?.dhuhr}',
                      style: TextStyle(
                          color: (currentDate.hour >= 20 ||
                              currentDate.hour <= 5)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500))
                ] else
                  if (currentDate.hour >= dhuhr.hour &&
                      currentDate.hour <= asr.hour ||
                      currentDate.minute <= asr.minute) ...[
                    Text('${prayer.data?.timings?.asr}',
                        style: TextStyle(
                            color: (currentDate.hour >= 20 ||
                                currentDate.hour <= 5)
                                ? Colors.white
                                : Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500)),
                  ] else
                    if (currentDate.hour >= asr.hour &&
                        currentDate.hour <= maghrib.hour ||
                        currentDate.minute <= maghrib.minute) ...[
                      Text(
                        '${prayer.data?.timings?.maghrib}',
                        style: TextStyle(
                            color: (currentDate.hour >= 20 || currentDate
                                .hour <= 5)
                                ? Colors.white
                                : Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ] else
                      if (currentDate.hour >= maghrib.hour &&
                          currentDate.hour <= isha.hour &&
                          currentDate.minute <= isha.minute) ...[
                        Text(
                          '${prayer.data?.timings?.isha}',
                          style: TextStyle(
                              color: (currentDate.hour >= 20 ||
                                  currentDate.hour <= 5)
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
              const SizedBox(
                height: 35.0,
              ),
              Container(
                padding: const EdgeInsetsDirectional.only(
                    top: 10, bottom: 10, start: 16, end: 16),
                height: 370.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(30.0),
                  color: ModeCubit
                      .getContext(context)
                      .isDark == true
                      ? (currentDate.hour >= 20 && currentDate.hour <= 5 ||
                      currentDate.timeZoneOffset.inHours <= 5)
                      ? Colors.white
                      : azanBoxColor.withOpacity(.6)
                      : Colors.black.withOpacity(.5),
                ),
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildPrayerList(
                            prayersList,
                            index,
                            context,
                            upcomingPrayerTime(currentDate, prayerTimes)),
                    separatorBuilder: (context, index) => divider(),
                    itemCount: prayerTimesTiming.length),
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

  List<String> prayersName = [
    'Fajr',
    'Sunrise',
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha',
  ];

  int openIndex = -1;
  bool isNotificationOn = true;
  bool isVibrationOn = false;
  bool isMute = false;
  int selectedIcon = 0;

  List<bool> isNotificationOnList = [];
  List<bool> isVibrationOnList = [];
  List<bool> isMuteList = [];

  @override
  void initState() {
    super.initState();
    isNotificationOnList = List.generate(prayersName.length, (index) => true);
    isVibrationOnList = List.generate(prayersName.length, (index) => false);
    isMuteList = List.generate(prayersName.length, (index) => false);
  }

  void toggleOpen(int index) {
    setState(() {
      openIndex = openIndex == index ? -1 : index;
      switch (selectedIcon) {
        case 0:
          isNotificationOn = true;
          isVibrationOn = false;
          isMute = false;
          selectedIcon = 0;
          break;
        case 1:
          isNotificationOn = false;
          isVibrationOn = true;
          isMute = false;
          selectedIcon = 1;
          break;
        case 2:
          isNotificationOn = false;
          isVibrationOn = false;
          isMute = true;
          selectedIcon = 2;
          break;
        default:
          isNotificationOn = true;
          isVibrationOn = false;
          isMute = false;
          selectedIcon = 0;
          break;
      }
    });
  }

  Widget buildPrayerList(List<String> prayers, int index, BuildContext context,
      DateTime notificationPrayerTime) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 16.0,
        color: ModeCubit
            .getContext(context)
            .isDark == true
            ? Colors.black
            : Colors.white.withOpacity(.7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Expanded(
          flex: 1,
          child: Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints.tightForFinite(),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                      width: openIndex == index ? 240 : 50,
                      decoration: const ShapeDecoration(
                        shape: StadiumBorder(),
                      ),
                    ),
                    if (isNotificationOnList[index])
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIcon = 0;
                            isNotificationOnList[index] = true;
                            isVibrationOnList[index] = false;
                            isMuteList[index] = false;
                          });
                          toggleOpen(index);
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: green.withOpacity(.4),
                          child: IconButton(
                            onPressed: () {
                              toggleOpen(index);
                            },
                            icon: Icon(Icons.notifications_active,
                                color: Colors.green.shade400),
                          ),
                        ),
                      ),
                    if (isVibrationOnList[index])
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIcon = 1;
                            isNotificationOnList[index] = false;
                            isVibrationOnList[index] = true;
                            isMuteList[index] = false;
                            print(selectedIcon);
                          });
                          toggleOpen(index);
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.orange.shade200,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  toggleOpen(index);
                                  isVibrationOnList[index] =
                                  !isVibrationOnList[index];
                                });
                                NotificationService
                                    .scheduleWithNoSoundNotification(
                                  title: '${prayers[index]} prayer',
                                  body:
                                  '${prayers[index]} prayer time is coming',
                                  flutterLocalNotificationsPlugin:
                                  flutterLocalNotificationsPlugin,
                                  time: notificationPrayerTime,
                                );
                              },
                              icon: const Icon(Icons.vibration,
                                  color: Colors.orangeAccent)),
                        ),
                      ),
                    if (isMuteList[index])
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIcon = 2;
                            isNotificationOnList[index] = false;
                            isVibrationOnList[index] = false;
                            isMuteList[index] = true;
                          });
                          toggleOpen(index);
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.grey.shade400,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  toggleOpen(index);
                                  isMuteList[index] = !isMuteList[index];
                                });
                                NotificationService.stopNotification();
                              },
                              icon: const Icon(Icons.notifications_off,
                                  color: Colors.black12)),
                        ),
                      ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: openIndex == index ? 1 : 0,
                      child: Container(
                        padding: const EdgeInsetsDirectional.only(start: 40),
                        width: 280,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 16.0,
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.orange.shade200,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      toggleOpen(index);
                                      isVibrationOnList[index] =
                                      !isVibrationOnList[index];
                                    });
                                    NotificationService
                                        .scheduleWithNoSoundNotification(
                                      title: '${prayers[index]} prayer',
                                      body:
                                      '${prayers[index]} prayer time is coming',
                                      flutterLocalNotificationsPlugin:
                                      flutterLocalNotificationsPlugin,
                                      time: notificationPrayerTime,
                                    );
                                  },
                                  icon: const Icon(Icons.vibration,
                                      color: Colors.orangeAccent)),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.black26,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      toggleOpen(index);
                                      isMuteList[index] = !isMuteList[index];
                                    });
                                    NotificationService.stopNotification();
                                  },
                                  icon: const Icon(Icons.notifications_off,
                                      color: Colors.black26)),
                            ),
                            IconButton(
                              onPressed: () {
                                toggleOpen(index);
                                setState(() {
                                  isNotificationOn = false;
                                  isVibrationOn = false;
                                  isMute = false;
                                });
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    const SizedBox(width: 15.0),
                    Text(prayersName[index].tr),
                    const Spacer(),
                    Text(prayers[index].tr),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var upcomingLevelPrayer;

  String upcomingPrayer() {
    if (currentDate.isAtSameMomentAs(fajr!)) {
      return upcomingLevelPrayer = 'Fajr';
    } else if (currentDate.isAtSameMomentAs(dhuhr!) &&
        dhuhr!.hourOfPeriod == currentDate.timeZoneOffset.inHours) {
      return upcomingLevelPrayer = 'Dhuhr';
    } else if (currentDate.isAtSameMomentAs(asr!) &&
        asr!.hourOfPeriod == currentDate.timeZoneOffset.inHours) {
      return upcomingLevelPrayer = 'Asr';
    } else if (currentDate.isAtSameMomentAs(maghrib!) &&
        maghrib!.hourOfPeriod == currentDate.timeZoneOffset.inHours) {
      return upcomingLevelPrayer = 'Maghrib';
    } else if (currentDate.isAtSameMomentAs(isha!) &&
        isha!.hourOfPeriod == currentDate.timeZoneOffset.inHours) {
      return upcomingLevelPrayer = 'Isha';
    }
    return upcomingLevelPrayer;
  }
}
