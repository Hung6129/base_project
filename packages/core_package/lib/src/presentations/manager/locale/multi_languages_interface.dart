import 'package:flutter/material.dart';

abstract interface class MultiLanguages {

  Locale get locale;

  Locale get initializeLocale;

  void changeLocale(Locale locale);
}