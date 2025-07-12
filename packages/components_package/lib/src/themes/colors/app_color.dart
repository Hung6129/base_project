import 'components/error_color.dart';
import 'components/info_color.dart';
import 'components/neutral_color.dart';
import 'components/primary_color.dart';
import 'components/success_color.dart';
import 'components/warning_color.dart';

abstract base class AppColor {
  PrimaryColor get primary;

  InfoColor get info;

  NeutralColor get neutral;

  SuccessColor get success;

  WarningColor get warning;

  ErrorColor get error;
}

final class LightAppColor extends AppColor {
  @override
  PrimaryColor get primary => LightPrimaryColor();

  @override
  NeutralColor get neutral => LightNeutralColor();

  @override
  InfoColor get info => LightInfoColor();

  @override
  SuccessColor get success => LightSuccessColor();

  @override
  ErrorColor get error => LightErrorColor();

  @override
  WarningColor get warning => LightWarningColor();
}

final class DarkAppColor extends AppColor {
  @override
  PrimaryColor get primary => DarkPrimaryColor();

  @override
  NeutralColor get neutral => DarkNeutralColor();

  @override
  InfoColor get info => DarkInfoColor();

  @override
  SuccessColor get success => DarkSuccessColor();

  @override
  ErrorColor get error => DarkErrorColor();

  @override
  WarningColor get warning => DarkWarningColor();
}
