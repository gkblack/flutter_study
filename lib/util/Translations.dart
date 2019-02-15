import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 处理翻译
class Translations {
  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;
  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  static Translations of(BuildContext context){
    return Localizations.of(context, Translations);
  }
}