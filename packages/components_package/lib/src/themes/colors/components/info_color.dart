import 'package:flutter/material.dart';

abstract base class InfoColor {
  Color get one;

  Color get two;

  Color get three;

  Color get four;

  Color get five;

  Color get six;

  Color get seven;

  Color get eight;
}

final class LightInfoColor extends InfoColor {
  @override
  Color get eight => const Color(0xff004D66);

  @override
  Color get five => const Color(0xff00C1FF);

  @override
  Color get four => const Color(0xff33CDFF);

  @override
  Color get one =>const Color(0xffCCF3FF);

  @override
  Color get seven =>const Color(0xff007499);

  @override
  Color get six =>const Color(0xff009ACC);

  @override
  Color get three => const Color(0xff66DAFF);

  @override
  Color get two => const Color(0xff99E6FF);


}

final class DarkInfoColor extends InfoColor {
  @override
  Color get eight => const Color(0xff004D66);

  @override
  Color get five => const Color(0xff00C1FF);

  @override
  Color get four => const Color(0xff33CDFF);

  @override
  Color get one =>const Color(0xffCCF3FF);

  @override
  Color get seven =>const Color(0xff007499);

  @override
  Color get six =>const Color(0xff009ACC);

  @override
  Color get three => const Color(0xff66DAFF);

  @override
  Color get two => const Color(0xff99E6FF);

}
