import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/cubit/mode_cubit.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({Key? key}) : super(key: key);

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

        TimeOfDay fajr = stringToTimeOfDay(prayer!.data!.timings!.fajr!);
        TimeOfDay sunrise = stringToTimeOfDay(prayer.data!.timings!.sunrise!);
        TimeOfDay dhuhr = stringToTimeOfDay(prayer.data!.timings!.dhuhr!);
        TimeOfDay asr = stringToTimeOfDay(prayer.data!.timings!.asr!);
        TimeOfDay maghrib = stringToTimeOfDay(prayer.data!.timings!.maghrib!);
        TimeOfDay isha = stringToTimeOfDay(prayer.data!.timings!.isha!);

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
                    color: (currentDate.hour >= 16 &&
                            currentDate.timeZoneOffset.inHours <= 5)
                        ? Colors.white
                        : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16.0,
              ),
              if (fajr.hour < isha.hour &&
                  fajr.hour > sunrise.hour &&
                  fajr.hour < dhuhr.hour) ...[
                Text(
                  'Fajr'.tr,
                  style: TextStyle(
                      color: (currentDate.hour >= 16 &&
                              currentDate.timeZoneOffset.inHours <= 5)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ] else if (dhuhr.hourOfPeriod > sunrise.hourOfPeriod &&
                  dhuhr.hour > sunrise.hour &&
                  dhuhr.hour > asr.hour &&
                  dhuhr.hourOfPeriod > asr.hourOfPeriod) ...[
                Text('Dhuhr'.tr,
                    style: TextStyle(
                        color: (currentDate.hour >= 16 &&
                                currentDate.timeZoneOffset.inHours <= 5)
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500))
              ] else if (currentDate.hour > dhuhr.hour &&
                  currentDate.hour <= asr.hour &&
                  currentDate.timeZoneOffset.inHours > dhuhr.periodOffset &&
                  currentDate.timeZoneOffset.inHours <= asr.periodOffset) ...[
                Text('Asr'.tr,
                    style: TextStyle(
                        color: (currentDate.hour >= 16 &&
                                currentDate.timeZoneOffset.inHours <= 5)
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ] else if (maghrib.hourOfPeriod > asr.hourOfPeriod &&
                  maghrib.hour > asr.hour &&
                  maghrib.hour < isha.hour &&
                  maghrib.hourOfPeriod < isha.hourOfPeriod) ...[
                Text('Maghrib'.tr,
                    style: TextStyle(
                        color: (currentDate.hour >= 16 &&
                                currentDate.timeZoneOffset.inHours <= 5)
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ] else if (isha.hourOfPeriod > maghrib.hourOfPeriod &&
                  isha.hour > maghrib.hour &&
                  isha.hour < fajr.hour &&
                  isha.hourOfPeriod < fajr.hourOfPeriod) ...[
                Text('Isha'.tr,
                    style: TextStyle(
                        color: (currentDate.hour >= 16 &&
                                currentDate.timeZoneOffset.inHours <= 5)
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ],
              const SizedBox(
                height: 16.0,
              ),
              buildTime(context),
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
                        ? (currentDate.hour >= 16 &&
                                currentDate.timeZoneOffset.inHours <= 5)
                            ? azanBoxColor.withOpacity(.6)
                            : Colors.white
                        : Colors.black.withOpacity(.5)),
                child: buildPrayerList(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTime(context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(MainCubit.getContext(context).duration.inHours);
    final minutes = twoDigits(
        MainCubit.getContext(context).duration.inMinutes.remainder(60));
    final seconds = twoDigits(
        MainCubit.getContext(context).duration.inSeconds.remainder(60));
    return Text(
      '$hours hr:$minutes min:$seconds sec'.tr,
      style: TextStyle(
        fontSize: 20.0,
        color:
            (currentDate.hour >= 16 && currentDate.timeZoneOffset.inHours <= 5)
                ? Colors.white
                : Colors.black,
      ),
    );
  }

  Widget buildPrayerList(context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints.tightForFinite(),
                  child: Container(
                    child: Stack(
                      children: [
                        Container(),
                        Container(
                          width: 40.0,
                          decoration: BoxDecoration(
                            color: green.withOpacity(.4),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              MainCubit.getContext(context)
                                  .changeNotificationIcon();
                            },
                            icon: const Icon(
                              Icons.notifications_active,
                              color: green,
                            ),
                          ),
                        ),
                        // AnimatedOpacity(
                        //   duration: const Duration(milliseconds: 400),
                        //   opacity: MainCubit.getContext(context).isOpen ? 1 : 0,
                        //   child: Container(
                        //     width: 200,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //       children: [
                        //         IconButton(
                        //           onPressed: () {},
                        //           icon: Icon(Icons.notifications_off,
                        //               color: Colors.grey.withOpacity(.8)),
                        //         ),
                        //         IconButton(
                        //           onPressed: () {},
                        //           icon: Icon(Icons.notifications_off,
                        //               color: Colors.grey.withOpacity(.8)),
                        //         ),
                        //         IconButton(
                        //           onPressed: () {},
                        //           icon: Icon(Icons.notifications_off,
                        //               color: Colors.grey.withOpacity(.8)),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Text(
                  'Fajr'.tr,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.fajr}',
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
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
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.sunrise}',
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
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
                  'Dhuhr'.tr,
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.dhuhr}',
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
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
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.asr}',
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
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
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.maghrib}',
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
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
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.isha}',
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

// Widget buildPrayerList(context) => Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: green.withOpacity(.4),
//             child: IconButton(
//               color: green,
//               onPressed: () {},
//               icon: const Icon(Icons.notifications_active_rounded),
//             ),
//           ),
//           const SizedBox(
//             width: 12.0,
//           ),
//           const Text(
//             'Fajr',
//             style: TextStyle(
//               fontSize: 16.0,
//             ),
//           ),
//           const Spacer(),
//           Text(
//               '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.fajr}',
//               style: const TextStyle(
//                 fontSize: 16.0,
//               )),
//         ],
//       ),
//     );
}
