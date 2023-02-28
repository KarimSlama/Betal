import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

var selectedDay = HijriCalendar.now();

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
                color: (currentDate.timeZoneOffset.inHours > 5 &&
                        currentDate.hour >= 20)
                    ? azanBoxColor
                    : Colors.white.withOpacity(.6)),
            padding: const EdgeInsetsDirectional.symmetric(
                vertical: 16.0, horizontal: 14.0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.green.shade800,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text('$selectedDay'),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 60,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => buildCalendarSelectItem(),
            itemCount: 7,
            separatorBuilder: (context, index) => const SizedBox(
              width: 10.0,
            ),
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 18.0, vertical: 14.0),
          height: 320.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(30.0),
            color: (currentDate.timeZoneOffset.inHours < 5 &&
                    currentDate.hour > 20)
                ? azanBoxColor.withOpacity(.6)
                : Colors.white,
          ),
          child: buildPrayerList(context),
        ),
      ],
    );
  }

  Widget buildPrayerList(context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8),
            child: Row(
              children: [
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
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8),
            child: Row(
              children: [
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
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8),
            child: Row(
              children: [
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
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8),
            child: Row(
              children: [
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
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8),
            child: Row(
              children: [
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
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8),
            child: Row(
              children: [
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

  Future<void> selectDate(context) async {
    final HijriCalendar? picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedDay,
      lastDate: HijriCalendar()
        ..hYear = 1445
        ..hMonth = 9
        ..hDay = 25,
      firstDate: HijriCalendar()
        ..hYear = 1438
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null) {
      setState(() {
        selectedDay = picked;
      });
    }
  }
}

Widget buildCalendarSelectItem() => Container(
      alignment: Alignment.center,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Thu',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '3',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
