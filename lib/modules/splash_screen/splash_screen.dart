import 'package:Betal/layouts/mainLayout.dart';
import 'package:Betal/modules/onboarding_screen/onboarding_screen.dart';
import 'package:Betal/shared/components/components.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/data/local_storage/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

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
            children: [
              const Image(
                image: AssetImage(
                  'assets/images/logo.png',
                ),
                width: 150.0,
              ),
              const SizedBox(
                height: 18.0,
              ),
              Text(
                'Prayer Time'.tr,
                style: const TextStyle(
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
        widget = MainLayout();
      } else {
        widget = const OnBoardingScreen();
      }
    });
  } //end _navigateToHome()

  @override
  void initState() {
    super.initState();
    getAddressName();
    navigateToHome().then((value) {
      navigateAndFinish(context, widget);
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Placemark? placeMark_;

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    latitude = position.latitude;
    longitude = position.longitude;
    CacheHelper.saveData(key: 'latitude', value: position.latitude);
    CacheHelper.saveData(key: 'longitude', value: position.longitude);
    placeMark_ = placeMark[0];
    city = placeMark_!.locality;
    country = placeMark_!.country;
    CacheHelper.saveData(key: 'city', value: placeMark_!.locality);
    CacheHelper.saveData(key: 'country', value: placeMark_!.country);
  }

  Future getAddressName() async {
    Position position = await _determinePosition();
    getAddressFromLatLong(position);
    CacheHelper.saveData(key: 'city', value: true);
    CacheHelper.saveData(key: 'country', value: true);
  }
}
