abstract base class BaseAppDimens {
  double get toolbarHeight;

  double get toolbarHomeHeight;

  double get toolbarBalanceHeight;

  double get toolbarElevation;

  double get bottomNavBarIconSize;

  double get bottomNavBarElevation;

  double get buttonElevation;

  double get buttonHeight;

  double get buttonMinWidth;

  double get buttonRadius;

  double get bottomSheetRadius;

  double get textFieldMinHeight;

  double get textFieldMaxHeight;

  double get textFieldContentPaddingTop;

  double get textFieldContentPaddingBottom;

  double get textFieldContentPaddingLeft;

  double get textFieldContentPaddingRight;

  double get textFieldIconSize;

  double get toastHeight;

  double get paddingDefault;

  double get textFieldRadius;

  double get cardRadius;

  double get dialogRadius;

  double get chipRadius;

  double get bottomSheetIndicatorRadius;

  double get listViewPadding;

  double get cardPadding;

  double get buttonHeightS;

  double get buttonHeightM;

  double get buttonHeightL;

  double get borderWidthBottom;

  double get tabHeightL;

  double get tabHeightS;

  double get itemRadius;
}

final class AppDimens extends BaseAppDimens {
  @override
  double get bottomNavBarElevation => 0;

  @override
  double get bottomNavBarIconSize => 32;

  @override
  double get bottomSheetRadius => 24;

  @override
  double get buttonElevation => 0;

  @override
  double get buttonHeight => 46;

  @override
  double get buttonMinWidth => 120;

  @override
  double get buttonRadius => 12;

  @override
  double get cardRadius => 16;

  @override
  double get dialogRadius => 16;

  @override
  double get paddingDefault => 16;

  @override
  double get textFieldContentPaddingBottom => 14;

  @override
  double get textFieldContentPaddingTop => 14;

  @override
  double get textFieldIconSize => 20;

  @override
  double get textFieldMaxHeight => 68;

  @override
  double get textFieldMinHeight => 44;

  @override
  double get textFieldRadius => 10;

  @override
  double get toastHeight => 47;

  @override
  double get toolbarElevation => 0;

  @override
  double get toolbarHeight => 48;

  @override
  double get chipRadius => 30;

  @override
  double get textFieldContentPaddingLeft => 20;

  @override
  double get textFieldContentPaddingRight => 20;

  @override
  double get bottomSheetIndicatorRadius => 20;

  @override
  double get listViewPadding => 16;

  @override
  double get cardPadding => 24;

  @override
  double get buttonHeightL => 56;

  @override
  double get buttonHeightM => 40;

  @override
  double get buttonHeightS => 32;

  @override
  double get borderWidthBottom => 1;

  @override
  double get tabHeightL => 48;

  @override
  double get tabHeightS => 40;

  @override
  double get toolbarBalanceHeight => 48;

  @override
  double get toolbarHomeHeight => 48;

  @override
  double get itemRadius => 10;
}
