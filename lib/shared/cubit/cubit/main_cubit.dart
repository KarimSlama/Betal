import 'dart:async';
import 'dart:io';
import 'package:Betal/models/calendar_time_model.dart';
import 'package:Betal/models/data_with_day_model.dart';
import 'package:Betal/models/prayer_data_model.dart';
import 'package:Betal/modules/calendar_screen/calender_screen.dart';
import 'package:Betal/modules/nearest_masjed_screen/nearest_masjed_screen.dart';
import 'package:Betal/modules/prayer_screen/prayer_screen.dart';
import 'package:Betal/modules/qibla_screen/qibla_screen.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:Betal/shared/data/network/dio_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  // void checkNextPray(){
  //   if()
  // }

  static const countDownDuration = Duration(hours: 3, minutes: 0);
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

  CalendarTimeModel? calendarTimeModel;

  void getTimeWithCalendar(
      {required String month, required String city, required String country}) {
    emit(GetTimeWithCityLoadingState());

    DioHelper.getData(
      url: 'calendarByCity/2023/$month',
      query: {
        'city': city,
        'country': country,
        'method': 8,
      },
    ).then((value) {
      calendarTimeModel = CalendarTimeModel.fromJson(value.data);
      print(value);
      emit(GetTimeWithCitySuccessState());
    }).catchError((error) {
      print('Get Data error is: $error');
      emit(GetTimeWithCityErrorState());
    });
  }

  DataWithDayModel? dataWithDayModel;

  void dayWithDate(
      {required String date,
      required double latitude,
      required double longitude}) {
    emit(DataWithDayLoadingState());

    DioHelper.getData(
      url: 'timings',
      query: {
        'date': date,
        'latitude': latitude,
        'longitude': longitude,
        'method': 8,
      },
    ).then((value) {
      dataWithDayModel = DataWithDayModel.fromJson(value.data);
      print(value);
      emit(DataWithDaySuccessState());
    }).catchError((error) {
      print('Get Data error is: $error');
      emit(DataWithDayErrorState());
    });
  }

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();

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

  void changeSwitchIcon() {
    isSwitch = !isSwitch;
    emit(SwitchIconChangedState());
  }

  FilePickerResult? result;
  File? file;

  Future<void> chooseAudio() async {
    result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      file = File(result!.files.single.path ?? '');
      emit(PickAudioSuccessState());
    } else {
      print('error when open picker');
      emit(PickAudioErrorState());
    }
  }
}
