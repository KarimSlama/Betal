import 'dart:ffi';

import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40.0,
              ),
              Text(
                'UPCOMING',
                style: TextStyle(
                    color: (currentDate.timeZoneOffset.inHours < 5 &&
                            currentDate.hour > 20)
                        ? Colors.white
                        : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text('Asr',
                  style: TextStyle(
                      color: (currentDate.timeZoneOffset.inHours < 5 &&
                              currentDate.hour > 20)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.dhuhr}',
                  style: TextStyle(
                      color: (currentDate.timeZoneOffset.inHours < 5 &&
                              currentDate.hour > 20)
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 16.0,
              ),
              buildTime(context),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 14.0, vertical: 10.0),
                  height: 370.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(30.0),
                      color: (currentDate.timeZoneOffset.inHours < 5 &&
                              currentDate.hour > 20)
                          ? azanBoxColor.withOpacity(.6)
                          : Colors.white),
                  child: buildPrayerList(context)),
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
      '$hours hr:$minutes min:$seconds sec',
      style: TextStyle(
        fontSize: 20.0,
        color: (currentDate.timeZoneOffset.inHours < 5 && currentDate.hour > 20)
            ? Colors.white
            : Colors.black,
      ),
    );
  }

  Widget buildPrayerList(context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                const Text(
                  'Fajr',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.fajr}',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                const Text(
                  'Sunrise',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.sunrise}',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                const Text(
                  'Dhuhr',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.dhuhr}',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                const Text(
                  'Asr',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.asr}',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                const Text(
                  'Maghrib',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.maghrib}',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                const Text(
                  'Isha',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.isha}',
                  style: const TextStyle(
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
