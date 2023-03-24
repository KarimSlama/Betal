import 'package:Betal/modules/settings_screen/settings_screen.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/cubit/mode_cubit.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class MainLayout extends StatelessWidget {
  MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        var main = MainCubit.getContext(context).prayerDataModel;
        return DefaultTabController(
          length: 3,
          child: ConditionalBuilder(
            condition: main != null,
            builder: (context) {
              return SafeArea(
                child: Scaffold(
                  body: Directionality(
                    textDirection: selectedCurrentLanguage == 'Arabic'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        if (currentDate.hour >= 5 && currentDate.hour <= 11 ||
                            currentDate.timeZoneOffset.inHours >= 5 &&
                                currentDate.timeZoneOffset.inHours <= 11) ...[
                          const Image(
                            image: AssetImage('assets/images/after_dhuhr.jpg'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ] else if (currentDate.hour >= 12 &&
                                currentDate.hour <= 15 ||
                            currentDate.timeZoneOffset.inHours >= 12 &&
                                currentDate.timeZoneOffset.inHours <= 3) ...[
                          const Image(
                            image: AssetImage('assets/images/light_bk.jpg'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ] else if (currentDate.hour >= 15 &&
                                currentDate.hour <= 19 ||
                            currentDate.timeZoneOffset.inHours >= 3 &&
                                currentDate.timeZoneOffset.inHours <= 7) ...[
                          const Image(
                            image:
                                AssetImage('assets/images/midmorning_bk.png'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ] else if (currentDate.hour >= 20 &&
                                currentDate.hour <= 5 ||
                            currentDate.timeZoneOffset.inHours <= 5) ...[
                          const Image(
                            image: AssetImage('assets/images/night_bk.png'),
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ],
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '$city',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: (currentDate.hour >= 20 ||
                                                currentDate.hour <= 5)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  IconButton(
                                      padding: EdgeInsetsDirectional.zero,
                                      onPressed: () {},
                                      icon: const Icon(Icons.refresh),
                                      iconSize: 16,
                                      color: (currentDate.hour >= 20 ||
                                              currentDate.hour <= 5)
                                          ? Colors.white
                                          : Colors.black),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        isInstalled(context);
                                      },
                                      icon:
                                          const Icon(FontAwesomeIcons.whatsapp),
                                      iconSize: 30,
                                      color: (currentDate.hour >= 20 ||
                                              currentDate.hour <= 5)
                                          ? Colors.white
                                          : Colors.black),
                                  IconButton(
                                      onPressed: () {
                                        Share.share(
                                            'https://battal.page.link/dowload-app');
                                      },
                                      icon: const Icon(Icons.share_outlined),
                                      iconSize: 30,
                                      color: (currentDate.hour >= 20 ||
                                              currentDate.hour <= 5)
                                          ? Colors.white
                                          : Colors.black),
                                  IconButton(
                                      onPressed: () {
                                        navigateTo(
                                            context, const SettingsScreen());
                                      },
                                      icon: const Icon(Icons.settings),
                                      iconSize: 30,
                                      color: (currentDate.hour >= 20 ||
                                              currentDate.hour <= 5)
                                          ? Colors.white
                                          : Colors.black),
                                ],
                              ),
                              Text(
                                '${main!.data!.date!.gregorian!.weekday!.en}'
                                    .tr,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: (currentDate.hour >= 20 ||
                                            currentDate.hour <= 5)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              const SizedBox(
                                height: 7.0,
                              ),
                              Text(
                                '${selectedHijriDay.hDay} ${selectedCurrentLanguage == 'Arabic' ? main.data!.date!.hijri!.month!.ar : main.data!.date!.hijri!.month!.en}, ${selectedHijriDay.hYear}',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: (currentDate.hour >= 20 ||
                                            currentDate.hour <= 5)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              MainCubit.getContext(context).screens[
                                  MainCubit.getContext(context).currentIndex],
                            ],
                          ),
                        ),
                        Container(
                          height: 92.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(30.0),
                              topEnd: Radius.circular(30.0),
                            ),
                            color: ModeCubit.getContext(context).isDark == true
                                ? Colors.white
                                : Colors.black.withOpacity(.5),
                          ),
                          padding:
                              const EdgeInsetsDirectional.only(bottom: 10.0),
                          child: TabBar(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 15.0),
                            onTap: (index) {
                              MainCubit.getContext(context)
                                  .changeBottomNavigation(index);
                            },
                            labelColor:
                                ModeCubit.getContext(context).isDark == true
                                    ? Colors.black
                                    : Colors.white.withOpacity(.6),
                            indicatorColor: bottomIndicator,
                            indicatorWeight: 3,
                            labelPadding: const EdgeInsets.all(10.0),
                            tabs: [
                              Tab(
                                icon: Icon(
                                  FontAwesomeIcons.personPraying,
                                  color: ModeCubit.getContext(context).isDark ==
                                          true
                                      ? Colors.black
                                      : Colors.white.withOpacity(.5),
                                ),
                                text: 'Prayers'.tr,
                              ),
                              Tab(
                                icon: Icon(
                                  FontAwesomeIcons.starOfDavid,
                                  size: 22.0,
                                  color: ModeCubit.getContext(context).isDark ==
                                          true
                                      ? Colors.black
                                      : Colors.white.withOpacity(.5),
                                ),
                                text: 'Qibla'.tr,
                              ),
                              Tab(
                                icon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: ModeCubit.getContext(context).isDark ==
                                          true
                                      ? Colors.black
                                      : Colors.white.withOpacity(.5),
                                ),
                                text: 'Calendar'.tr,
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
            fallback: (context) => const Center(
                child: (SpinKitFadingCube(
              color: green,
              size: 40,
            ))),
          ),
        );
      },
    );
  }

  Future<void> isInstalled(context) async {
    SnackBar snackBar;
    final val = await WhatsappShare.isInstalled(package: Package.whatsapp);
    if (val == true) {
      share();
    } else {
      snackBar = SnackBar(
        content: const Text('Whats app is not installed on your device'),
        action: SnackBarAction(
          label: 'Download?',
          onPressed: () async {
            await launchUrlString('https://www.whatsapp.com/download/');
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> share() async {
    await WhatsappShare.share(
      text: 'Free Download Prayer Times For all cities around the world',
      linkUrl: 'https://battal.page.link/dowload-app',
      phone: '911234567890',
    );
  }
}
