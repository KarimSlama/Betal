import 'package:Betal/models/translation.dart';
import 'package:Betal/modules/splash_screen/splash_screen.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/observer.dart';
import 'package:Betal/shared/data/local_storage/controller/app_language.dart';
import 'package:Betal/shared/data/local_storage/controller/cache_helper.dart';
import 'package:Betal/shared/data/network/dio_helper.dart';
import 'package:Betal/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await DioHelper.init();
  // await GetStorage.init();
  city = CacheHelper.getData(key: 'city');
  country = CacheHelper.getData(key: 'country');
  var selectedLanguage = await CacheHelper.getData(key: 'language');
  print(selectedLanguage);
  print(city);
  runApp(MyApp(
    selectedLanguage: selectedLanguage,
  ));
}

class MyApp extends StatelessWidget {
  String? selectedLanguage;

  MyApp({this.selectedLanguage, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..changeLanguage(selectedLanguage)
        ..getTimeWithCity(city: city, country: country)
        ..startTimer()
        ..reset(),
      child: GetMaterialApp(
        home: const SplashScreen(),
        theme: lightTheme,
        translations: Translation(),
        locale: Locale(selectedLanguage ?? 'en'),
        fallbackLocale: const Locale('en'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
