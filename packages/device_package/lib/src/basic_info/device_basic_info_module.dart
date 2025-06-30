import 'dart:async';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_package/src/basic_info/android_device_id.dart'
    show AndroidDeviceId;
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
export 'devices.dart';

class DeviceBasicInfoModule extends MicroPackageModule {
  Future<AndroidDeviceId> _registerAndroidDeviceId() {
    return const AndroidId()
        .getId()
        .then((value) {
          return AndroidDeviceId(value);
        })
        .onError((error, stackTrace) => AndroidDeviceId(null));
  }

  @override
  FutureOr<void> init(GetItHelper gh) async {
    await gh.lazySingletonAsync<PackageInfo>(
      PackageInfo.fromPlatform,
      preResolve: true,
    );
    await gh.lazySingletonAsync<BaseDeviceInfo>(
      () => DeviceInfoPlugin().deviceInfo,
      preResolve: true,
    );
    await gh.lazySingletonAsync<AndroidDeviceId>(
      _registerAndroidDeviceId,
      preResolve: true,
    );
  }
}
