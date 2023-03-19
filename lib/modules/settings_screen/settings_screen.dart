import 'package:Betal/layouts/mainLayout.dart';
import 'package:Betal/models/prayer_model.dart';
import 'package:Betal/notification_model.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/cubit/mode_cubit.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:Betal/shared/data/local_storage/cache_helper.dart';
import 'package:Betal/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  final PrayerModel? prayerModel;
  final String? localAudio;

  const SettingsScreen({this.prayerModel, this.localAudio, Key? key})
      : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool initialValue = true;
  bool isSwitch = true;
  bool isMadhab = true;
  bool isClockSystem = true;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var prayerController = TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is PrayerInsertDatabaseState) {
          Navigator.pop(context);
          prayerController.clear();
        } // end if()
      },
      builder: (context, state) {
        var prayers = MainCubit.getContext(context).prayersList;
        return Directionality(
          textDirection: selectedCurrentLanguage == 'Arabic'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                'Setting'.tr,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
              leading: IconButton(
                icon: selectedCurrentLanguage == 'Arabic'
                    ? const Icon(Icons.arrow_forward_ios_rounded)
                    : const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  navigateTo(context, MainLayout());
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 14.0),
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
                      data: ThemeData()
                          .copyWith(dividerColor: Colors.transparent),
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
                            isSwitch,
                            (value) {
                              setState(() {
                                isSwitch = !isSwitch;
                              });
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
                      data: ThemeData()
                          .copyWith(dividerColor: Colors.transparent),
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
                                  MainCubit.getContext(context)
                                      .pickFile()
                                      .then((value) {
                                    if (MainCubit.getContext(context).result !=
                                        null) {
                                      scaffoldKey.currentState
                                          ?.showBottomSheet((context) => Form(
                                                key: formKey,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadiusDirectional
                                                            .only(
                                                      topStart:
                                                          Radius.circular(30),
                                                      topEnd:
                                                          Radius.circular(30),
                                                    ),
                                                    color: ModeCubit.getContext(
                                                                    context)
                                                                .isDark ==
                                                            true
                                                        ? azanBoxColor
                                                            .withOpacity(.2)
                                                        : Colors.white,
                                                  ),
                                                  height: 300,
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 14.0,
                                                      vertical: 30.0),
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        controller:
                                                            prayerController,
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'prayer name is important'
                                                                .tr;
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          label: Text(
                                                              'enter prayer name'
                                                                  .tr),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              15.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 40.0,
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadiusDirectional
                                                                  .circular(
                                                                      10.0),
                                                          color: Colors
                                                              .green.shade800,
                                                        ),
                                                        child: MaterialButton(
                                                          onPressed: () {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              MainCubit.getContext(
                                                                      context)
                                                                  .insertIntoDatabase(
                                                                prayerName:
                                                                    prayerController
                                                                        .text,
                                                                prayerPath: MainCubit
                                                                        .getContext(
                                                                            context)
                                                                    .filePath,
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                            'Add Prayer'.tr,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          .closed
                                          .then((value) {
                                        MainCubit.getContext(context)
                                            .changeBottomSheetState(false);
                                      });
                                    }
                                    MainCubit.getContext(context)
                                        .changeBottomSheetState(true);
                                  });
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    buildPrayers(prayers[index], index),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 10.0,
                                ),
                                itemCount: MainCubit.getContext(context)
                                    .prayersList
                                    .length,
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
                    Theme(
                      data: ThemeData()
                          .copyWith(dividerColor: Colors.transparent),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
                      data: ThemeData()
                          .copyWith(dividerColor: Colors.transparent),
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
                              '$selectedCurrentLanguage',
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                      data: ThemeData()
                          .copyWith(dividerColor: Colors.transparent),
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
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isMadhab = true;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14.0),
                                        child: Text(
                                          'Shafi'.tr,
                                          style: TextStyle(
                                            color: isMadhab
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
                                          isMadhab = false;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14.0),
                                        child: Text(
                                          'Hanafi'.tr,
                                          style: TextStyle(
                                            color: !isMadhab
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
                              color:
                                  ModeCubit.getContext(context).isDark == true
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
                              value:
                                  ModeCubit.getContext(context).isDark == true
                                      ? MainCubit.getContext(context).isSwitch =
                                          false
                                      : MainCubit.getContext(context).isSwitch =
                                          true,
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
                              color:
                                  ModeCubit.getContext(context).isDark == true
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
                              value: isClockSystem,
                              onChanged: (value) {
                                setState(() {
                                  isClockSystem = !isClockSystem;
                                });
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
                    Container(
                      height: 500,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildNotificationSystem(index),
                        separatorBuilder: (context, index) => divider(),
                        itemCount: prayersName.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPrayers(Map prayers, index) => InkWell(
        onTap: () async {
          selectedSound = prayers['prayer_name'];
          CacheHelper.saveData(key: 'prayer_call', value: selectedSound);
          selectedSound = CacheHelper.getData(key: 'prayer_call');
          print('the selected sound is $selectedSound');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          child: Text(
            prayers['prayer_name'],
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
    'English'.tr,
    'French'.tr,
    'Arabic'.tr,
    'Turkish'.tr,
    'German'.tr,
    'Spanish'.tr,
    'Portuguese'.tr,
    'Russian'.tr,
  ];

  Widget buildLanguages(index) => InkWell(
        onTap: () {
          setState(() {
            if (languages[index].isNotEmpty) {
              selectedCurrentLanguage = languages[index];
            }
          });
          Get.updateLocale(Locale(selectedCurrentLanguage));
          CacheHelper.saveData(key: 'language', value: selectedCurrentLanguage);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          child: Text(
            languages[index],
            style: TextStyle(
              color: selectedCurrentLanguage == languages[index]
                  ? Colors.green
                  : ModeCubit.getContext(context).isDark == true
                      ? Colors.black
                      : Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      );

  List<String> prayersName = [
    'Fajr'.tr,
    'Sunrise'.tr,
    'Dhuhr'.tr,
    'Asr'.tr,
    'Maghrib'.tr,
    'Isha'.tr,
  ];

  List<String> notificationStatus = [
    'Notify With Sound'.tr,
    'Alert Only'.tr,
    'OFF'.tr,
  ];

  List<int> notificationSelected = [];

  @override
  void initState() {
    super.initState();
    notificationSelected = List.generate(prayersName.length, (index) => 0);
  }

  Widget buildNotificationSystem(index) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        onExpansionChanged: (value) {},
        title: Row(
          children: [
            Text(
              prayersName[index].tr,
              style: TextStyle(
                color: ModeCubit.getContext(context).isDark == true
                    ? Colors.black
                    : Colors.white,
                fontSize: 16.0,
              ),
            ),
            const Spacer(),
            Text(
              notificationStatus[notificationSelected[index]].tr,
              style: TextStyle(
                color: ModeCubit.getContext(context).isDark == true
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
            height: 180,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, listIndex) =>
                        buildNotificationSystemList(listIndex, index),
                    separatorBuilder: (context, listIndex) => const SizedBox(
                      height: 10.0,
                    ),
                    itemCount: notificationStatus.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationSystemList(listIndex, index) {
    return InkWell(
      onTap: () {
        setState(() {
          notificationSelected[index] = listIndex;
          switch (notificationSelected[index]) {
            case 2:
              NotificationService.stopNotification();
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
        child: Text(
          notificationStatus[listIndex].tr,
          style: TextStyle(
            color: notificationSelected[index] == listIndex
                ? Colors.green
                : ModeCubit.getContext(context).isDark == true
                    ? Colors.black
                    : Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  int selected = 0;
  bool isOpen = true;

  Widget customSwitch(
          context, String text, bool isSwitch, Function onChangeMethod) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                Container(
                  width: 250,
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: ModeCubit.getContext(context).isDark == true
                          ? Colors.black
                          : Colors.white,
                      fontSize: 16.0,
                    ),
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
