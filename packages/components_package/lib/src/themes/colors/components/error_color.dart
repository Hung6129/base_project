import 'package:flutter/material.dart';

abstract base class ErrorColor {
  Color get one;

  Color get two;

  Color get three;

  Color get four;

  Color get five;

  Color get six;

  Color get seven;

  Color get eight;
}

final class LightErrorColor extends ErrorColor {
  @override
  Color get eight => const Color(0xff5A1414);

  @override
  Color get five => const Color(0xffE03232);

  @override
  Color get four => const Color(0xffE65B5B);

  @override
  Color get one => const Color(0xffF9D6D6);

  @override
  Color get seven => const Color(0xffF9D6D6);

  @override
  Color get six => const Color(0xffB32828);

  @override
  Color get three => const Color(0xffEC8484);

  @override
  Color get two => const Color(0xffF3ADAD);
}

final class DarkErrorColor extends ErrorColor {
  @override
  Color get eight => const Color(0xff5A1414);

  @override
  Color get five => const Color(0xffE03232);

  @override
  Color get four => const Color(0xffE65B5B);

  @override
  Color get one => const Color(0xffF9D6D6);

  @override
  Color get seven => const Color(0xffF9D6D6);

  @override
  Color get six => const Color(0xffB32828);

  @override
  Color get three => const Color(0xffEC8484);

  @override
  Color get two => const Color(0xffF3ADAD);
}
