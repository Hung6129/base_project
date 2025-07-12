import 'package:flutter/material.dart';

abstract base class SuccessColor {
  Color get one;

  Color get two;

  Color get three;

  Color get four;

  Color get five;

  Color get six;

  Color get seven;

  Color get eight;
}

final class LightSuccessColor extends SuccessColor {
  @override
  Color get eight => const Color(0xff006050);

  @override
  Color get five => const Color(0xff00F1C9);

  @override
  Color get four => const Color(0xff33F4D4);

  @override
  Color get one => const Color(0xffCCFCF4);

  @override
  Color get seven => const Color(0xff009179);

  @override
  Color get six => const Color(0xff00C1A1);

  @override
  Color get three => const Color(0xff66F7DF);

  @override
  Color get two => const Color(0xff99F9E9);
}

final class DarkSuccessColor extends SuccessColor {
  @override
  Color get eight => const Color(0xff006050);

  @override
  Color get five => const Color(0xff006050);

  @override
  Color get four => const Color(0xff33F4D4);

  @override
  Color get one => const Color(0xffCCFCF4);

  @override
  Color get seven => const Color(0xff009179);

  @override
  Color get six => const Color(0xff00C1A1);

  @override
  Color get three => const Color(0xff66F7DF);

  @override
  Color get two => const Color(0xff99F9E9);
}
