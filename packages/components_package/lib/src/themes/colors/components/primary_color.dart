import 'package:flutter/material.dart';

abstract base class PrimaryColor {
  Color get zero;

  Color get one;

  Color get two;

  Color get three;

  Color get four;

  Color get five;

  Color get six;

  Color get seven;

  Color get eight;

  Color get other;
}

final class LightPrimaryColor extends PrimaryColor {
  @override
  Color get eight => const Color(0xff5D101A);

  @override
  Color get five => const Color(0xffE82840);

  @override
  Color get four => const Color(0xffED5366);

  @override
  Color get one => const Color(0xffFAD4D9);

  @override
  Color get seven => const Color(0xff8B1826);

  @override
  Color get six => const Color(0xffBA2033);

  @override
  Color get three => const Color(0xffF17E8C);

  @override
  Color get two => const Color(0xffF6A9B3);

  @override
  Color get zero => throw UnimplementedError();

  @override
  Color get other => const Color(0xffEF0F2A);
}

final class DarkPrimaryColor extends PrimaryColor {
  @override
  Color get eight => const Color(0xff5D101A);

  @override
  Color get five => const Color(0xffE82840);

  @override
  Color get four => const Color(0xffED5366);

  @override
  Color get one => const Color(0xffFAD4D9);

  @override
  Color get seven => const Color(0xff8B1826);

  @override
  Color get six => const Color(0xffBA2033);

  @override
  Color get three => const Color(0xffF17E8C);

  @override
  Color get two => const Color(0xffF6A9B3);

  @override
  Color get zero => throw UnimplementedError();

  @override
  Color get other => const Color(0xffEF0F2A);
}
