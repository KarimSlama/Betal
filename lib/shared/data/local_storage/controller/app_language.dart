import 'package:Betal/shared/data/local_storage/controller/cache_helper.dart';
import 'package:Betal/shared/data/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLanguage extends GetxController {
  var appLocal = 'en';

  // Locale initializing = CacheHelper.getData(key: 'language') == 'de'
  //     ? const Locale('de')
  //     : const Locale('en');
  //
// void changeLanguage(String languageCode) {
//   Locale locale = Locale(languageCode);
//   CacheHelper.saveData(key: 'language', value: languageCode);
//   Get.updateLocale(locale);
//   }

@override
void onInit() async {
  super.onInit();
  LocalStorage localStorage = LocalStorage();
  appLocal = await localStorage.languageSelected == null
      ? 'en'
      : localStorage.languageSelected.toString();
  update();
  Get.updateLocale(Locale(appLocal));
}

void changeLanguage(String languageType) async {
  LocalStorage localStorage = LocalStorage();
  if (localStorage == languageType) {
    return;
  }
  switch (languageType) {
    case 'en':
      appLocal = 'en';
      localStorage.saveLanguage('en');
      break;
    case 'ar':
      appLocal = 'ar';
      localStorage.saveLanguage('ar');
      break;
    case 'fr':
      appLocal = 'fr';
      localStorage.saveLanguage('fr');
      break;
    case 'de':
      appLocal = 'de';
      localStorage.saveLanguage('de');
      break;
    case 'es':
      appLocal = 'es';
      localStorage.saveLanguage('es');
      break;
    case 'pt':
      appLocal = 'pt';
      localStorage.saveLanguage('pt');
      break;
    case 'ru':
      appLocal = 'ru';
      localStorage.saveLanguage('ru');
      break;
    case 'tr':
      appLocal = 'tr';
      localStorage.saveLanguage('tr');
      break;
  }
  update();
}
}
