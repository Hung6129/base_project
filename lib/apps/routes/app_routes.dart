import 'package:core_package/core_package.dart';
import 'package:go_router/go_router.dart';

class AppRoutes extends BaseAppRoutes {
  @override
  List<RouteBase> get $routes => [];

  @override
  bool get debugLogDiagnostics => true;

  @override
  String get initialLocation => '';

  Uri get currentLocation => router.routeInformationProvider.value.uri;
}
