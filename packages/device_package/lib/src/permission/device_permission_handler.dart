import 'dart:async';
import 'dart:io';
import 'package:device_package/device_package.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart'
    show PermissionStatus;

final class DevicePermissionHandler {
  static Future<PermissionStatus> requestTrackingTransparency() async {
    var status = await Permission.appTrackingTransparency.status;
    await Permission.appTrackingTransparency.request();
    // if (!status.isGranted) {
    //   return await Permission.appTrackingTransparency.request();
    // }
    return status;
  }

  static Future<PermissionStatus> requestCamera() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      return await Permission.camera.request();
    }
    return status;
  }

  static Future<PermissionStatus> requestPhoto() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      if (Platform.isAndroid) {
        final androidSDK = DeviceHelper.getAndroidVersionSDK();
        if (androidSDK <= 32) {
          status = await Permission.storage.request();
        } else {
          status = await Permission.photos.request();
        }
      } else {
        status = await Permission.photos.request();
      }
    }
    return status;
  }

  static Future<PermissionStatus> requestActivityDetection({
    ActionWhenPermissionIsDenied? actionWhenDenied,
  }) async {
    var status =
        await (Platform.isAndroid
            ? Permission.activityRecognition.status
            : Permission.sensors.status);

    if (status.isDenied) {
      if (Platform.isAndroid) {
        status = await Permission.activityRecognition.request();
      } else {
        status = await Permission.sensors.request();
      }
      if (status.isPermanentlyDenied) {
        await checkActionWhenPermissionIsDenied(actionWhenDenied);
      }
    } else if (status.isPermanentlyDenied) {
      await checkActionWhenPermissionIsDenied(actionWhenDenied);
    }

    return status;
  }

  static Future<PermissionStatus> requestLocation({
    ActionWhenPermissionIsDenied? actionWhenDenied,
  }) async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.location.request();
      if (status.isPermanentlyDenied) {
        // unawaited(openAppSettings());
        await checkActionWhenPermissionIsDenied(actionWhenDenied);
      }
    } else if (status.isPermanentlyDenied) {
      // unawaited(openAppSettings());
      await checkActionWhenPermissionIsDenied(actionWhenDenied);
    }

    return status;
  }

  static void openSettings() {
    openAppSettings();
  }

  static Future<void> checkActionWhenPermissionIsDenied(
    ActionWhenPermissionIsDenied? actionWhenDenied,
  ) async {
    if (actionWhenDenied != null) {
      await showModalBottomSheet<bool>(
        context: actionWhenDenied.context,
        builder: (_) => actionWhenDenied.action,
      ).then((value) {
        // ignore: avoid_print
        print('action when permission is denied value: $value');
        if (value == true) {
          unawaited(openAppSettings());
        }
      });
    }
  }
}

final class ActionWhenPermissionIsDenied {
  final BuildContext context;
  final Widget action;

  ActionWhenPermissionIsDenied({required this.context, required this.action});
}
