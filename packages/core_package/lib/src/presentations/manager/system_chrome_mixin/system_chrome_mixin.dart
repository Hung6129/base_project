import 'package:flutter/services.dart';

mixin SystemChromeMixin {
  void setStatusBarColor(Color color){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
    ));
  }
}