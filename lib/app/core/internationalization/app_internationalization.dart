import 'package:get/get.dart';

import 'en_US.dart';
import 'id_ID.dart';

class AppInternationalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'id_ID': id_ID,
      };
}
