import 'package:easy_localization/easy_localization.dart';

enum Sex {
  dog,
  bitch,
}

extension ToString on Sex {
  String toLocalizedString() {
    switch (this) {
      case Sex.dog:
      return tr('sex.dog');

      case Sex.bitch:
      return tr('sex.bitch');

      default:
      return null;
    }
  }
}