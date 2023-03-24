import 'dart:async';
import 'dart:io';
import 'package:Betal/models/calendar_time_model.dart';
import 'package:Betal/models/country_model.dart';
import 'package:Betal/models/data_with_day_model.dart';
import 'package:Betal/models/prayer_data_model.dart';
import 'package:Betal/modules/calendar_screen/calender_screen.dart';
import 'package:Betal/modules/prayer_screen/prayer_screen.dart';
import 'package:Betal/modules/qibla_screen/qibla_screen.dart';
import 'package:Betal/shared/cubit/states/main_state.dart';
import 'package:Betal/shared/data/network/country_dio_helper.dart';
import 'package:Betal/shared/data/network/dio_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
      emit(GetTimeWithCitySuccessState());
    }).catchError((error) {
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
      emit(GetTimeWithCitySuccessState());
    }).catchError((error) {
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
    }).catchError((error) {
      emit(DataWithDayErrorState());
    });
  }

  CountryModel? countriesModel;
  List<CountryModel> countries = [];

  void getAllCountries() {
    emit(GetAllCountriesLoadingState());

    CountryDioHelper.getData(
      url: 'v3.1/all',
    ).then((value) {
      value.data.forEach((element) {
        countries.add(CountryModel.fromJson(element));
      });
      print(countries.length);
      emit(GetAllCountriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllCountriesErrorState());
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

  Database? database;
  List<Map> prayersList = [];

  String? filePath;
  FilePickerResult? result;

  Future<void> pickFile() async {
    try {
      result = await FilePicker.platform.pickFiles(type: FileType.audio);
      if (result != null) {
        String? path = result!.files.single.path;
        if (path != null) {
          File file = File(path);
          Directory rawDir = await getApplicationDocumentsDirectory();
          String rawPath = '${rawDir.path}/raw/';
          await Directory(rawPath)
              .create(recursive: true); // create the "raw" directory
          String fileName = file.path.split('/').last;
          String _filePath = '$rawPath$fileName';
          await file.copy(_filePath);
          filePath = _filePath;
          emit(PickAudioSuccessState());
        } else {
          emit(PickAudioErrorState());
        }
      } else {
        emit(PickAudioErrorState());
      }
    } catch (e) {
      emit(PickAudioErrorState());
    }
  }

  Future<Directory> getRawDirectory() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Directory rawDirectory = Directory("${directory.path}/betal_app/raw");
    if (!rawDirectory.existsSync()) {
      rawDirectory.createSync(recursive: true);
    }
    return rawDirectory;
  }

  void createDatabase() {
    openDatabase(
      'prayer_call.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE prayers (id INTEGER PRIMARY KEY, prayer_name TEXT, prayer_path TEXT)')
            .then((value) {});
      },
      onOpen: (database) {
        getAllData(database);
      },
    ).then((value) {
      database = value;
    });
  } //end createDatabase()

  insertIntoDatabase({
    required var prayerName,
    required var prayerPath,
  }) async {
    await database?.transaction((transaction) {
      return transaction
          .rawInsert(
              'INSERT INTO prayers(prayer_name, prayer_path) VALUES("$prayerName", "$prayerPath")')
          .then((value) {
        emit(PrayerInsertDatabaseState());
        getAllData(database);
      });
    });
  }

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
