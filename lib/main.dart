import 'package:Betal/models/translation.dart';
import 'package:Betal/modules/splash_screen/splash_screen.dart';
import 'package:Betal/notification_model.dart';
import 'package:Betal/prayer_notification.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/cubit/mode_cubit.dart';
import 'package:Betal/shared/cubit/observer.dart';
import 'package:Betal/shared/cubit/states/mode_state.dart';
import 'package:Betal/shared/data/local_storage/cache_helper.dart';
import 'package:Betal/shared/data/network/country_dio_helper.dart';
import 'package:Betal/shared/data/network/dio_helper.dart';
import 'package:Betal/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

void main() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  PrayerNotification.initializeLocalNotifications();
  await CacheHelper.init();
  await DioHelper.init();
  await CountryDioHelper.init();
  latitude = CacheHelper.getData(key: 'latitude');
  longitude = CacheHelper.getData(key: 'longitude');
  city = CacheHelper.getData(key: 'city');
  country = CacheHelper.getData(key: 'country');
  bool? isDark = CacheHelper.getData(key: 'isDark');
  selectedCurrentLanguage = CacheHelper.getData(key: 'language');
  selectedSound = CacheHelper.getData(key: 'prayer_call');
  runApp(MyApp(
    selectedLanguage: selectedCurrentLanguage,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  String? selectedLanguage;
  bool? isDark;

  MyApp({this.selectedLanguage, this.isDark, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainCubit()
            ..getTimeWithCity(city: city, country: country)
            ..createDatabase()
            ..getAllCountries(),
        ),
        BlocProvider(
          create: (context) => ModeCubit()..changeMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<ModeCubit, ModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GetMaterialApp(
            home: const SplashScreen(),
            theme:
                ModeCubit.getContext(context).isDark ? lightTheme : darkTheme,
            translations: Translation(),
            locale: Locale(selectedCurrentLanguage ?? 'English'),
            fallbackLocale: const Locale('English'),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
