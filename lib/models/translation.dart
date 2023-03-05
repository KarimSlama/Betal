import 'package:Betal/languages/ar.dart';
import 'package:Betal/languages/de.dart';
import 'package:Betal/languages/en.dart';
import 'package:Betal/languages/es.dart';
import 'package:Betal/languages/fr.dart';
import 'package:Betal/languages/pt.dart';
import 'package:Betal/languages/ru.dart';
import 'package:Betal/languages/tr.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
        'fr': fr,
        'de': de,
        'tr': tr,
        'es': es,
        'pt': pt,
        'ru': ru,
      };
}
