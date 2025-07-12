import 'package:core_package/src/networks/config/key_by_platform.dart';

enum BuildMode {
  dev('dev'),
  stg('stg'),
  uat('uat'),
  prod('prod');

  final String value;

  const BuildMode(this.value);
}

abstract class BuildConfigMode {
  final KeyByPlatform<String>? appID;

  final int connectTimeout;

  final int receiveTimeout;

  final Map<String, dynamic> env;

  BuildConfigMode.internal({
    required String endPoint,
    this.appID,
    this.env = const {},
    this.connectTimeout = 30000,
    this.receiveTimeout = 30000,
  });

  String get endPoint;
}
