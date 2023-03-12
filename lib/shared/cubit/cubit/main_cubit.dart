import 'dart:async';
import 'dart:io';
import 'package:Betal/models/calendar_time_model.dart';
import 'package:Betal/models/data_with_day_model.dart';
import 'package:Betal/models/prayer_data_model.dart';
import 'package:Betal/modules/calendar_screen/calender_screen.dart';
import 'package:Betal/modules/prayer_screen/prayer_screen.dart';
import 'package:Betal/modules/qibla_screen/qibla_screen.dart';
import 'package:Betal/shared/components/constants.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:Betal/shared/data/local_storage/cache_helper.dart';
import 'package:Betal/shared/data/network/dio_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainLayoutInitializeState());

  static MainCubit getContext(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    PrayerScreen(),
    const QiblaScreen(),
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

  void getTimeWithCalendar({required String city, required String country}) {
    emit(GetTimeWithCityLoadingState());

    DioHelper.getData(
      url: 'timingsByCity/',
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

  void getDayWithDate({
    required String date,
    required double latitude,
    required double longitude,
  }) {
    DioHelper.getData(
      url: 'timings/$date',
      query: {
        'latitude': latitude,
        'longitude': longitude,
        'method': 8,
      },
    ).then((value) {
      dataWithDayModel = DataWithDayModel.fromJson(value.data);
      print(value);
    }).catchError((error) {
      print('Get Data error is: $error');
      emit(DataWithDayErrorState());
    });
  }

  bool isExpansionTileOpen = true;

  void changeExpansionTileIcon(isOpened) {
    isExpansionTileOpen = !isOpened;
    emit(ExpansionTileIconChangedState());
  }

  bool isOpen = false;

  void changeNotificationIcon() {
    isOpen = !isOpen;
    emit(NotificationIconChangedState());
  }

  bool isSwitch = true;

  void changeSwitchIcon() {
    isSwitch = !isSwitch;
    emit(SwitchIconChangedState());
  }

  late Database database;

  FilePickerResult? result;
  File? file;

  Future chooseAudio() async {
    result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      file = File(result!.files.single.path ?? '');
      print('The audio path is: ${file?.path.toString()}');
      emit(PickAudioSuccessState());
    } else {
      print('error when open picker');
      emit(PickAudioErrorState());
    }
  }

  insertIntoDatabase({
    required var prayerName,
    required var prayerPath,
  }) async {
    await database.transaction((transaction) {
      return transaction
          .rawInsert(
              'INSERT INTO prayers(prayer_name, prayer_path) VALUES("$prayerName", "${file!.path}")')
          .then((value) {
        print('$value a new record inserted');
        emit(PrayerInsertDatabaseState());
        getAllData(database);
      });
    });
  }

  List<Map> prayersList = [];

  void getAllData(database) {
    prayersList = [];

    emit(PrayersGetAllDatabaseLoadingState());
    database.rawQuery('SELECT * FROM prayers').then((value) {
      value.forEach((element) {
        prayersList.add(element);
      });
      emit(PrayersGetAllDatabaseState());
    });
  } //end getAllData()

  bool isBottomSheetShown = false;

  void changeBottomSheetState(bool isShown) {
    isBottomSheetShown = isShown;
    emit(PrayersBottomSheetState());
  } //end changeBottomSheetState()
}
