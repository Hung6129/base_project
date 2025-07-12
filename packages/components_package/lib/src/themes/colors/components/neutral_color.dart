import 'package:flutter/material.dart';

abstract base class NeutralColor {
  Color get zero;

  Color get one;

  Color get two;

  Color get three;

  Color get four;

  Color get five;

  Color get six;

  Color get seven;

  Color get eight;
}

final class LightNeutralColor extends NeutralColor {
  @override
  Color get one => const Color(0xffF4F4F4);

  @override
  Color get eight => const Color(0xff111315);

  @override
  Color get five => const Color(0xff33383F);

  @override
  Color get four => const Color(0xff6F767E);

  @override
  Color get seven => const Color(0xff1A1D1F);

  @override
  Color get six => const Color(0xff272B30);

  @override
  Color get two => const Color(0xffEFEFEF);

  @override
  Color get zero => const Color(0xffFFFFFF);

  @override
  Color get three => const Color(0xffDADADA);
}

final class DarkNeutralColor extends NeutralColor {
  @override
  Color get one => const Color(0xffF4F4F4);

  @override
  Color get eight => const Color(0xff111315);

  @override
  Color get five => const Color(0xff33383F);

  @override
  Color get four => const Color(0xff6F767E);

  @override
  Color get seven => const Color(0xff1A1D1F);

  @override
  Color get six => const Color(0xff272B30);

  @override
  Color get two => const Color(0xffEFEFEF);

  @override
  Color get zero => const Color(0xff000000);

  @override
  Color get three => const Color(0xffDADADA);
}
