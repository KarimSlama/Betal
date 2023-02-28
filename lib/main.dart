import 'package:Betal/modules/splash_screen/splash_screen.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/cubit/observer.dart';
import 'package:Betal/shared/data/cache_helper.dart';
import 'package:Betal/shared/data/network/dio_helper.dart';
import 'package:Betal/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await DioHelper.init();
  city = CacheHelper.getData(key: 'city');
  country = CacheHelper.getData(key: 'country');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..getAddressName()
        ..getTimeWithCity(city: city, country: country),
      lazy: false,
      // ..startTimer()
      // ..reset()
      child: MaterialApp(
        home: const SplashScreen(),
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
