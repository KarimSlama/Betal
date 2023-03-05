import 'dart:async';
import 'package:Betal/models/prayer_data_model.dart';
import 'package:Betal/modules/calendar_screen/calender_screen.dart';
import 'package:Betal/modules/nearest_masjed_screen/nearest_masjed_screen.dart';
import 'package:Betal/modules/prayer_screen/prayer_screen.dart';
import 'package:Betal/modules/qibla_screen/qibla_screen.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:Betal/shared/data/local_storage/controller/cache_helper.dart';
import 'package:Betal/shared/data/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

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

  String selectedLanguage = 'en';

  void changeLanguage(String? fromShared) {
    if (fromShared != null) {
      selectedLanguage = fromShared;
    } else {
      CacheHelper.saveData(key: 'language', value: selectedLanguage);
      emit(ChangeLanguageSuccessState());
    }
  }

  bool isExpansionTileOpen = true;

  void changeExpansionTileIcon(isOpened) {
    isExpansionTileOpen = !isOpened;
    emit(ExpansionTileIconChangedState());
  }

  bool isOpen = true;

  void changeNotificationIcon() {
    isOpen = !isOpen;
    emit(NotificationIconChangedState());
  }

  bool isSwitch = true;

  void changeSwitchIcon(isSwitched) {
    isSwitch = isSwitched;
    emit(SwitchIconChangedState());
  }
}
