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
import 'package:Betal/shared/data/network/dio_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
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

  Database? database;
  List<Map> prayersList = [];

  // File? file;

  // Future chooseAudio() async {
  //   result = await FilePicker.platform.pickFiles(type: FileType.audio);
  //   if (result != null) {
  //     file = File(result!.files.single.path ?? '');
  //     Directory rawDirectory = await getRawDirectory();
  //     await file?.copy("${rawDirectory.path}/${result?.files.single.name}");
  //     print('The audio path is: ${file?.path.toString()}');
  //     emit(PickAudioSuccessState());
  //   } else {
  //     print('error when open picker');
  //     emit(PickAudioErrorState());
  //   }
  // }

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
          print('The audio path is: ${filePath.toString()}');
          emit(PickAudioSuccessState());
        } else {
          print('Error: File path is null.');
          emit(PickAudioErrorState());
        }
      } else {
        print('Error: FilePickerResult is null.');
        emit(PickAudioErrorState());
      }
    } catch (e) {
      print('Error: $e');
      emit(PickAudioErrorState());
    }
  }

  // Future<void> saveToRaw(fileName) async {
  //   if (file != null && fileName != null) {
  //     var directory = await getExternalStorageDirectory();
  //     var directoryPath = directory!.path;
  //     await Directory(directoryPath).create(recursive: true);
  //
  //     File newFile = File(directoryPath);
  //     newFile.writeAsBytesSync(file!.readAsBytesSync());
  //   }
  // }

  Future<Directory> getRawDirectory() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Directory rawDirectory = Directory("${directory.path}/betal_app/raw");
    if (!rawDirectory.existsSync()) {
      rawDirectory.createSync(recursive: true);
    }
    return rawDirectory;
  }

  // Future<Directory> getApplicationDocumentsDirectory() async {
  //   final String? path = await Platform.getApplicationDocumentsPath();
  //   if (path == null) {
  //     print('error with path');
  //   }
  //   return Directory(path!);
  // }

  // Future<void> setDefaultSound() async {
  //   ByteData data = await rootBundle.load('assets/audio/ahmed_alnafis.mp3');
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String newPath = '${directory.path}/raw/';
  //   await Directory(newPath).create(recursive: true);
  //
  //   File newFile = File('$newPath/ahmed_alnafis.mp3');
  //   newFile.writeAsBytesSync(data.buffer.asUint8List());
  // }

  void createDatabase() {
    openDatabase(
      'prayer_call.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE prayers (id INTEGER PRIMARY KEY, prayer_name TEXT, prayer_path TEXT)')
            .then((value) {});
      },
      onOpen: (database) {
        insertIntoDatabase(
            prayerName: 'Ahmed Al nafis',
            prayerPath: '/data/user/0/com.example.battal/cache/'
                'file_picker/أذان يأخذك لعالم آخر _ A prayer call that takes you to another world(MP3_128K).mp3');
        getAllData(database);
        print('database opened');
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
        print('$value a new record inserted');
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
        print(element);
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
