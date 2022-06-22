import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:logger/logger.dart';

final logger = Logger();

extension IntX on num {
  String get convertDayFromToday {
    if (this == 0) {
      return 'today'.tr;
    } else if (this >= 30) {
      // its integer division
      int countMonth = this ~/ 30;
      if (countMonth == 1) {
        return '$countMonth ' + 'monthago'.tr;
      } else {
        return '$countMonth ' + 'monthsago'.tr;
      }
    } else if (this >= 120) {
      return 'longtimeago'.tr;
    } else {
      if (this == 1) {
        return '$this ' + 'dayago'.tr;
      } else {
        return '$this ' + 'daysago'.tr;
      }
    }
  }
}
