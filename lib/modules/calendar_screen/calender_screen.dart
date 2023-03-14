import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/cubit/mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:Betal/models/date_utils_model.dart' as date_util;
import 'package:intl/intl.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 60.0,
        ),
        GestureDetector(
          onTap: () {
            print('clicked on tap');
            selectDate(context);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: ModeCubit.getContext(context).isDark == true
                  ? (currentDate.hour >= 20 && currentDate.hour <= 5 ||
                  currentDate.timeZoneOffset.inHours <= 5)
                  ? Colors.white
                  : azanBoxColor.withOpacity(.6)
                  : Colors.black.withOpacity(.5),
            ),
            padding: const EdgeInsetsDirectional.symmetric(
                vertical: 16.0, horizontal: 14.0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: ModeCubit.getContext(context).isDark
                      ? Colors.green.shade800
                      : bottomIndicator,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  '$selectedHijriDay',
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
        ),
        const SizedBox(
          height: 20.0,
        ),
        horizontalCapsuleListView(),
        const SizedBox(
          height: 28.0,
        ),
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 18.0, vertical: 14.0),
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
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPrayerList(context, index),
            itemCount: 1,
          ),
        ),
      ],
    );
  }

  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();

  var selectedDay;
  var formattedDate;

  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDate);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDate.day);
    selectedDay = currentDate;
    formattedDate = DateFormat('dd-MM-yyyy').format(selectedDay);
    MainCubit.getContext(context).getDayWithDate(
      date: formattedDate,
      latitude: latitude,
      longitude: longitude,
    );
    super.initState();
  }

  Widget capsuleView(int index) {
    return Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 4),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDate = currentMonthList[index];
              selectedDay = currentDate;
              formattedDate = DateFormat('dd-MM-yyyy').format(selectedDay);
              print(formattedDate);
              MainCubit.getContext(context).getDayWithDate(
                date: formattedDate,
                latitude: latitude,
                longitude: longitude,
              );
            });
          },
          child: Container(
            width: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: (currentMonthList[index].day != currentDate.day)
                      ? [
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.6)
                        ]
                      : [
                          const Color(0xff5AE52A),
                          const Color(0xff5AE52A),
                          const Color(0xff5AE52A),
                        ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: const [0.0, 0.5, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadiusDirectional.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date_util.DateUtils
                        .weekdays[currentMonthList[index].weekday - 1].tr,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: (currentMonthList[index].day != currentDate.day)
                            ? HexColor("465876")
                            : Colors.white),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    currentMonthList[index].day.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: (currentMonthList[index].day != currentDate.day)
                            ? HexColor("465876")
                            : Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget horizontalCapsuleListView() {
    return Container(
      height: 80,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (context, index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget buildPrayerList(context, index) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: Row(
              children: [
                Text(
                  'Fajr'.tr,
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white.withOpacity(.7),
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  MainCubit.getContext(context)
                              .dataWithDayModel
                              ?.data
                              ?.timings
                              ?.fajr !=
                          null
                      ? '${MainCubit.getContext(context).dataWithDayModel?.data?.timings?.fajr}'
                      : '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.fajr}',
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
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: Row(
              children: [
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
                  MainCubit.getContext(context)
                              .dataWithDayModel
                              ?.data
                              ?.timings
                              ?.sunrise !=
                          null
                      ? '${MainCubit.getContext(context).dataWithDayModel?.data?.timings?.sunrise}'
                      : '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.sunrise}',
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
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: Row(
              children: [
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
                  MainCubit.getContext(context)
                              .dataWithDayModel
                              ?.data
                              ?.timings
                              ?.dhuhr !=
                          null
                      ? '${MainCubit.getContext(context).dataWithDayModel?.data?.timings?.dhuhr}'
                      : '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.dhuhr}',
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
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: Row(
              children: [
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
                  MainCubit.getContext(context)
                              .dataWithDayModel
                              ?.data
                              ?.timings
                              ?.asr !=
                          null
                      ? '${MainCubit.getContext(context).dataWithDayModel?.data?.timings?.asr}'
                      : '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.asr}',
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
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: Row(
              children: [
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
                  MainCubit.getContext(context)
                              .dataWithDayModel
                              ?.data
                              ?.timings
                              ?.maghrib !=
                          null
                      ? '${MainCubit.getContext(context).dataWithDayModel?.data?.timings?.maghrib}'
                      : '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.maghrib}',
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
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: Row(
              children: [
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
                  MainCubit.getContext(context)
                              .dataWithDayModel
                              ?.data
                              ?.timings
                              ?.isha !=
                          null
                      ? '${MainCubit.getContext(context).dataWithDayModel?.data?.timings?.isha}'
                      : '${MainCubit.getContext(context).prayerDataModel!.data!.timings!.isha}',
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

  Future<void> selectDate(context) async {
    final HijriCalendar? picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedHijriDay,
      lastDate: HijriCalendar()
        ..hYear = 1445
        ..hMonth = 9
        ..hDay = 25,
      firstDate: HijriCalendar()
        ..hYear = 1430
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null) {
      setState(() {
        selectedHijriDay = picked;
      });
    }
  }
}
