import 'package:Betal/layouts/mainLayout.dart';
import 'package:Betal/modules/onboarding_screen/onboarding_screen.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/cubit/main_cubit.dart';
import 'package:Betal/shared/data/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

late Widget widget;

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage(
                  'assets/images/logo.png',
                ),
                width: 150.0,
              ),
              SizedBox(
                height: 18.0,
              ),
              Text(
                'Prayer Time',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var isBoarding = CacheHelper.getData(key: 'onBoarding');

  Future navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (isBoarding != null) {
        widget = const MainLayout();
      } else {
        widget = const OnBoardingScreen();
      }
    });
  } //end _navigateToHome()

  @override
  void initState() {
    super.initState();
    // MainCubit.getContext(context).getTimeWithCity();
    // print('city is $city and the country is $country');
    navigateToHome().then((value) {
      navigateAndFinish(context, widget);
    });
  }
}
