import 'dart:async';

import 'package:Betal/models/location_model.dart';
import 'package:Betal/models/prayer_data_model.dart';
import 'package:Betal/models/timing.dart';
import 'package:Betal/modules/calendar_screen/calender_screen.dart';
import 'package:Betal/modules/nearest_masjed_screen/nearest_masjed_screen.dart';
import 'package:Betal/modules/prayer_screen/prayer_screen.dart';
import 'package:Betal/modules/qibla_screen/qibla_screen.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:Betal/shared/data/cache_helper.dart';
import 'package:Betal/shared/data/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainLayoutInitializeState());

  static MainCubit getContext(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const PrayerScreen(),
    const QiblaScreen(),
    const NearestMasjedScreen(),
    const CalenderScreen(),
  ];

  void changeBottomNavigation(int index) {
    currentIndex = index;
    emit(MainNavigationBarChangedState());
  }

  Timer? timer;
  bool isCountDown = true;
  static const countDownDuration = Duration(hours: 1, minutes: 0);
  Duration duration = const Duration();

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => minusTime(),
    );
    emit(StartTimerSuccessState());
  }

  void minusTime() {
    const addSeconds = 1;
    final seconds = duration.inSeconds - addSeconds;
    if (seconds > 0) {
      duration = Duration(seconds: seconds);
      emit(MinusTimerState());
    } else {
      timer?.cancel();
    }
  }

  void reset() {
    if (isCountDown) {
      duration = countDownDuration;
      emit(CountDownDurationState());
    } else {
      duration = const Duration();
      emit(ResetTimerState());
    }
  }

  PrayerDataModel? prayerDataModel;

  // there is an error here
  void getTimeWithCity({required String city, required String country}) {
    emit(GetTimeWithCityLoadingState());

    DioHelper.getData(
      url: 'timingsByCity',
      query: {
        'city': city,
        'country': country,
        'method': 8,
      },
    ).then((value) {
      prayerDataModel = PrayerDataModel.fromJson(value.data);
      print(value);
      emit(GetTimeWithCitySuccessState());
    }).catchError((error) {
      print('Get Data error is: $error');
      emit(GetTimeWithCityErrorState());
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
    placeMark_ = placeMark[0];
    city = placeMark_!.locality;
    country = placeMark_!.country;
    CacheHelper.saveData(key: 'city', value: placeMark_!.locality);
    CacheHelper.saveData(key: 'country', value: placeMark_!.country);
  }

  Future getAddressName() async {
    Position position = await _determinePosition();
    getAddressFromLatLong(position);
    // city = CacheHelper.getData(key: 'city');
    // country = CacheHelper.getData(key: 'country');
  }

  void changeNotificationIcon(){

  }

}
