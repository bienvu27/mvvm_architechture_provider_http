import 'package:flutter/material.dart';
import 'package:mvvm_architechture_provider_http/res/strings/Strings.dart';
import 'package:mvvm_architechture_provider_http/res/strings/english_strings.dart';
import 'package:mvvm_architechture_provider_http/res/strings/french_strings.dart';

import 'colors/app_colors.dart';
import 'dimentions/AppDimension.dart';

class Resources {
  BuildContext _context;

  Resources(this._context);

  Strings get strings {
    // It could be from the user preferences or even from the current locale
    Locale locale = Localizations.localeOf(_context);
    switch (locale.languageCode) {
      case 'fr':
        return FrenchStrings();
      default:
        return EnglishStrings();
    }
  }

  AppColors get color {
    return AppColors();
  }

  AppDimension get dimension {
    return AppDimension();
  }

  static Resources of(BuildContext context){
    return Resources(context);
  }
}