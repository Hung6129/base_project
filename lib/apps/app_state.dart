import 'dart:io';

import 'package:app/app/di/app_config.dart';
import 'package:app/presentations/main_screen/bottom_bar_inherited/badge_scope.dart';
import 'package:application/application.dart';
import 'package:components_module/components_module.dart';
import 'package:core_module/core_module.dart';
import 'package:device_module/device_module.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:localization_module/localization_module.dart';

final remoteLocalizations = getIt<RemoteLocalizationsDelegate>();

@LazySingleton()
final class AppState extends BaseAppState
    with LocaleProvider
    implements MultiThemes {
  final ThemeManager _themeManager;
  final RemoteLocalizationsService _remoteLocalizationsService;
  final CommonService _commonService;
  late Locale _initLocale;
  late final AppBadgeController badgeController;

  AppState(
    this._themeManager,
    this._remoteLocalizationsService,
    this._commonService,
  );

  @override
  Future<void> initAppState() async {
    badgeController = AppBadgeController();
    await _loadRemoteLocalizations();
    _initLocale = await _loadStorageLocale();
    await setLocale(_initLocale);
    // await _delayTime();
  }

  Future<void> _delayTime() async => Future.delayed(const Duration(seconds: 2));

  @override
  Future<void> changeTheme(ThemeMode mode) async {
    if (mode != _themeManager.themeMode) {
      _themeManager.changeThemeMode(mode);
      notifyListeners();
    }
  }

  @override
  ThemeMode get themeMode => _themeManager.themeMode;

  @override
  AppDarkTheme get darkTheme => _themeManager.baseDarkTheme;

  @override
  AppLightTheme get lightTheme => _themeManager.baseLightTheme;

  @override
  BaseTheme<AppThemeOptions> get currentTheme => _themeManager.currentTheme;

  @override
  AppColor get appColor => currentTheme.options!.color;

  @override
  AppFont get appFont => currentTheme.options!.font;

  void reset() {
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (locale.languageCode != this.locale.languageCode) {
      await super.setLocale(locale);
      remoteLocalizations.changeLocale(locale);
      notifyListeners();
    }
  }

  Future<void> _loadRemoteLocalizations() async {
    try {
      final loadRemoteCommand = LoadRemoteLocalizationsCommand();
      final commandResult = await _remoteLocalizationsService
          .submitCommand<RemoteLocalizationsResult>(loadRemoteCommand);
      if (commandResult.isSuccess) {
        await remoteLocalizations.load(
          this.locale,
          remoteSupportedLocales: commandResult.result!.supportedLocales,
          json: commandResult.result!.translations,
        );
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<Locale> _loadStorageLocale() async {
    try {
      var languageCode = await _commonService.storageLanguageCode();
      debugPrint('current language code $languageCode');
      if (languageCode == null) {
        languageCode = Platform.localeName.split('_').first;
      }
      final _locale = languageCode == null
          ? const Locale('en')
          : (languageCode == 'kor' || languageCode == 'ko'
                ? const Locale('ko')
                : Locale(languageCode));
      return _locale;
    } catch (e) {
      debugPrint('load local language code failed: $e');
      return const Locale('en');
    }
  }

  String get appVersion =>
      '${DeviceHelper.getAppVersion()}+${DeviceHelper.getBuildVersion()}';

  String get networkImageUrl => _commonService.networkImageUrl;

  AppFeaturesSetting? get appFeaturesSetting =>
      _commonService.appFeaturesSetting;

  List<String> get validDomainEmail =>
      _commonService.supportedEmailDomain?.validDomain ?? [];
}
