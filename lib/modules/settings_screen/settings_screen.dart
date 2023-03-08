import 'package:Betal/layouts/mainLayout.dart';
import 'package:Betal/main.dart';
import 'package:Betal/notification_model.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/cubit/mode_cubit.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:Betal/shared/data/local_storage/cache_helper.dart';
import 'package:Betal/styles/icon_broken.dart';
import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool initialValue = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        final params = CalculationMethod.karachi.getParameters();
        params.madhab = Madhab.hanafi;
        params.madhab = Madhab.shafi;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Setting'.tr,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                navigateTo(context, const MainLayout());
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        IconBroken.Setting,
                        color: ModeCubit.getContext(context).isDark == true
                            ? Colors.black
                            : Colors.white,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Setting'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: ModeCubit.getContext(context).isDark == true
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {},
                      title: Text(
                        'Location'.tr,
                        style: TextStyle(
                          color: ModeCubit.getContext(context).isDark == true
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      collapsedTextColor: Colors.green.shade800,
                      trailing: isOpen
                          ? Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.green.shade800)
                          : const Icon(Icons.arrow_forward_ios_outlined),
                      children: [
                        customSwitch(
                          context,
                          'Location Permission'.tr,
                          MainCubit.getContext(context).isSwitch ? false : true,
                          (value) {
                            MainCubit.getContext(context).changeSwitchIcon();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  divider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {},
                      title: Row(
                        children: [
                          Text(
                            'Call To Prayer With'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            backgroundColor: green,
                            radius: 20.0,
                            child: IconButton(
                              onPressed: () {
                                MainCubit.getContext(context).chooseAudio();
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      collapsedTextColor: Colors.green.shade800,
                      trailing: isOpen
                          ? Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.green.shade800)
                          : const Icon(Icons.arrow_forward_ios_outlined),
                      children: [
                        Container(
                          height: 100.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildPrayers(index),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10.0,
                                  ),
                                  itemCount: prayers.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  divider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {},
                      title: Row(
                        children: [
                          Text(
                            'Calendar'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            initialValue ? 'Hijri'.tr : 'Gregorian'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      collapsedTextColor: Colors.green.shade800,
                      trailing: isOpen
                          ? Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.green.shade800)
                          : const Icon(Icons.arrow_forward_ios_outlined),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      initialValue = true;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14.0),
                                    child: Text(
                                      'Hijri'.tr,
                                      style: TextStyle(
                                        color: initialValue
                                            ? Colors.green
                                            : ModeCubit.getContext(context)
                                                        .isDark ==
                                                    true
                                                ? Colors.black
                                                : Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      initialValue = false;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14.0),
                                    child: Text(
                                      'Gregorian'.tr,
                                      style: TextStyle(
                                        color: !initialValue
                                            ? Colors.green
                                            : ModeCubit.getContext(context)
                                                        .isDark ==
                                                    true
                                                ? Colors.black
                                                : Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  divider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {},
                      title: Row(
                        children: [
                          Text(
                            'Languages'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '$selectedLanguage',
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      collapsedTextColor: Colors.green.shade800,
                      trailing: isOpen
                          ? Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.green.shade800)
                          : const Icon(Icons.arrow_forward_ios_outlined),
                      children: [
                        Container(
                          height: 450,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildLanguages(index),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10.0,
                                  ),
                                  itemCount: languages.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  divider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {},
                      title: Text(
                        'Calculation Method'.tr,
                        style: TextStyle(
                          color: ModeCubit.getContext(context).isDark == true
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      collapsedTextColor: Colors.green.shade800,
                      trailing: isOpen
                          ? Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.green.shade800)
                          : const Icon(Icons.arrow_forward_ios_outlined),
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14.0),
                                      child: Text(
                                        'Shafi'.tr,
                                        style: TextStyle(
                                          color: ModeCubit.getContext(context)
                                                      .isDark ==
                                                  true
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14.0),
                                      child: Text(
                                        'Hanafi'.tr,
                                        style: TextStyle(
                                          color: ModeCubit.getContext(context)
                                                      .isDark ==
                                                  true
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            customSwitch(
                              context,
                              'Estimate Method Automatically'.tr,
                              MainCubit.getContext(context).isSwitch,
                              (value) {
                                MainCubit.getContext(context)
                                    .changeSwitchIcon();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  divider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 17),
                    child: Row(
                      children: [
                        Text(
                          'dark mode'.tr,
                          style: TextStyle(
                            color: ModeCubit.getContext(context).isDark == true
                                ? Colors.black
                                : Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        const Spacer(),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            activeColor: Colors.green.shade800,
                            trackColor: Colors.grey,
                            value: ModeCubit.getContext(context).isDark == true
                                ? MainCubit.getContext(context).isSwitch = false
                                : MainCubit.getContext(context).isSwitch = true,
                            onChanged: (value) {
                              setState(() {
                                ModeCubit.getContext(context).changeMode();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 17),
                    child: Row(
                      children: [
                        Text(
                          '24 Clock System'.tr,
                          style: TextStyle(
                            color: ModeCubit.getContext(context).isDark == true
                                ? Colors.black
                                : Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        const Spacer(),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            activeColor: Colors.green.shade800,
                            trackColor: Colors.grey,
                            value: true,
                            onChanged: (value) {
                              MainCubit.getContext(context).changeSwitchIcon();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Icon(
                        IconBroken.Notification,
                        color: ModeCubit.getContext(context).isDark == true
                            ? Colors.black
                            : Colors.white,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Notification'.tr,
                        style: TextStyle(
                          color: ModeCubit.getContext(context).isDark == true
                              ? Colors.black
                              : Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {},
                      title: Row(
                        children: [
                          Text(
                            'Fajr'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'OFF'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      collapsedTextColor: Colors.green.shade800,
                      trailing: isOpen
                          ? Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.green.shade800)
                          : const Icon(Icons.arrow_forward_ios_outlined),
                      children: [
                        Container(
                          height: 170,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildNotificationSystem(index),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10.0,
                                  ),
                                  itemCount: notificationSystem.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {},
                      title: Row(
                        children: [
                          Text(
                            'Sunrise'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'OFF'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      collapsedTextColor: Colors.green.shade800,
                      trailing: isOpen
                          ? Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.green.shade800)
                          : const Icon(Icons.arrow_forward_ios_outlined),
                      children: [
                        Container(
                          height: 170,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildNotificationSystem(index),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10.0,
                                  ),
                                  itemCount: notificationSystem.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {},
                      title: Row(
                        children: [
                          Text(
                            'Dhuhr'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'OFF'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      collapsedTextColor: Colors.green.shade800,
                      trailing: isOpen
                          ? Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.green.shade800)
                          : const Icon(Icons.arrow_forward_ios_outlined),
                      children: [
                        Container(
                          height: 170,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildNotificationSystem(index),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10.0,
                                  ),
                                  itemCount: notificationSystem.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {},
                      title: Row(
                        children: [
                          Text(
                            'Asr'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'OFF'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      collapsedTextColor: Colors.green.shade800,
                      trailing: isOpen
                          ? Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.green.shade800)
                          : const Icon(Icons.arrow_forward_ios_outlined),
                      children: [
                        Container(
                          height: 170,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildNotificationSystem(index),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10.0,
                                  ),
                                  itemCount: notificationSystem.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {},
                      title: Row(
                        children: [
                          Text(
                            'Maghrib'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Alert Only'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      collapsedTextColor: Colors.green.shade800,
                      trailing: isOpen
                          ? Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.green.shade800)
                          : const Icon(Icons.arrow_forward_ios_outlined),
                      children: [
                        Container(
                          height: 170,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildNotificationSystem(index),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10.0,
                                  ),
                                  itemCount: notificationSystem.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                  Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {},
                      title: Row(
                        children: [
                          Text(
                            'Isha'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Notify With Sound'.tr,
                            style: TextStyle(
                              color:
                                  ModeCubit.getContext(context).isDark == true
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      collapsedTextColor: Colors.green.shade800,
                      trailing: isOpen
                          ? Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.green.shade800)
                          : const Icon(Icons.arrow_forward_ios_outlined),
                      children: [
                        Container(
                          height: 170,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildNotificationSystem(index),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10.0,
                                  ),
                                  itemCount: notificationSystem.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<String> prayers = [
    'Ahmed Al nafis',
    'Yousef Moaty',
  ];

  Widget buildPrayers(index) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          child: Text(
            prayers[index],
            style: TextStyle(
              color: ModeCubit.getContext(context).isDark == true
                  ? Colors.black
                  : Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      );

  List<String> languages = [
    'English',
    'French',
    'Arabic',
    'Turkish',
    'German',
    'Spanish',
    'Portuguese',
    'Russian',
  ];

  Widget buildLanguages(index) => InkWell(
        onTap: () {
          setState(() {
            if (languages[index].isNotEmpty)
              selectedLanguage = languages[index];
          });
          Get.updateLocale(Locale(selectedLanguage));
          CacheHelper.saveData(key: 'language', value: selectedLanguage)
              .then((value) {
            //المفترض ان هنا هبدأ اغير اللغة بتاعت التطبيق كله
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          child: Text(
            languages[index],
            style: TextStyle(
              color: selectedLanguage == languages[index]
                  ? Colors.green
                  : Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      );

  List<String> notificationSystem = [
    'Notify With Sound',
    'Alert Only',
    'OFF',
  ];

  Widget buildNotificationSystem(index) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          child: Text(
            notificationSystem[index],
            style: TextStyle(
              color: ModeCubit.getContext(context).isDark == true
                  ? Colors.black
                  : Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      );

  int selected = 0;
  bool isOpen = true;

  Widget customSwitch(
          context, String text, bool isSwitch, Function onChangeMethod) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 7.0,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: ModeCubit.getContext(context).isDark == true
                        ? Colors.black
                        : Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    activeColor: Colors.green.shade800,
                    trackColor: Colors.grey,
                    value: isSwitch,
                    onChanged: (value) {
                      onChangeMethod(value);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
