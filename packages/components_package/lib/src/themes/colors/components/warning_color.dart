import 'package:flutter/material.dart';

abstract class WarningColor {
  Color get one;

  Color get two;

  Color get three;

  Color get four;

  Color get five;

  Color get six;

  Color get seven;

  Color get eight;
}

final class LightWarningColor extends WarningColor {
  @override
  Color get eight => const Color(0xff664E00);

  @override
  Color get five => const Color(0xffFFC400);

  @override
  Color get four => const Color(0xffFFD033);

  @override
  Color get one => const Color(0xffFFF3CC);

  @override
  Color get seven => const Color(0xff997600);

  @override
  Color get six => const Color(0xffCC9D00);

  @override
  Color get three => const Color(0xffFFDC66);

  @override
  Color get two => const Color(0xffFFE799);
}

final class DarkWarningColor extends WarningColor {
  @override
  Color get eight => const Color(0xff664E00);

  @override
  Color get five => const Color(0xffFFC400);

  @override
  Color get four => const Color(0xffFFD033);

  @override
  Color get one => const Color(0xffFFF3CC);

  @override
  Color get seven => const Color(0xff997600);

  @override
  Color get six => const Color(0xffCC9D00);

  @override
  Color get three => const Color(0xffFFDC66);

  @override
  Color get two => const Color(0xffFFE799);
}
