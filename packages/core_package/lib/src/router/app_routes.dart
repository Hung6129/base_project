import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class BaseAppRoutes {
  final BaseAppRouteRefreshListenable? refreshListenable;

  late final GoRouter router;

  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  BaseAppRoutes({this.refreshListenable}) {
    router = GoRouter(
      initialLocation: initialLocation,
      refreshListenable: refreshListenable,
      navigatorKey: rootNavigatorKey,
      routes: $routes,
      debugLogDiagnostics: debugLogDiagnostics,
      observers: observers,
      initialExtra: initialExtra,
      errorPageBuilder: errorPageBuilder,
      redirect: redirect,
      onException: onException,
    );
  }

  List<RouteBase> get $routes;

  String get initialLocation => '/';

  Object? get initialExtra => null;

  List<NavigatorObserver>? get observers => null;

  GoExceptionHandler? get onException => null;

  GoRouterPageBuilder? get errorPageBuilder => null;

  GoRouterWidgetBuilder? get errorBuilder => null;

  GoRouterRedirect? get redirect => null;

  bool get debugLogDiagnostics => false;

  void dispose() {
    refreshListenable?.dispose();
    router.dispose();
  }

  void pop<T extends Object?>([T? result]) {
    if (router.canPop()) {
      router.pop<T>(result);
    }
  }
}

/// A class that is used to notify the app that a route has been changed.
abstract class BaseAppRouteRefreshListenable extends ChangeNotifier {
  BaseAppRouteRefreshListenable();
}

/// It's a custom page that is used to create a slide up transition.
class SlideUpPage<T> extends CustomTransitionPage<T> {
  SlideUpPage({
    required super.child,
    super.transitionDuration,
    super.maintainState = true,
    super.fullscreenDialog = false,
    super.opaque = true,
    super.barrierDismissible = false,
    super.barrierColor,
    super.barrierLabel,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  }) : super(
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           const begin = Offset(0, 1);
           const end = Offset.zero;
           const curve = Curves.ease;

           final tween = Tween(
             begin: begin,
             end: end,
           ).chain(CurveTween(curve: curve));
           return SlideTransition(
             position: animation.drive(tween),
             child: child,
           );
         },
       );
}

/// It's a custom page that is used to fade in and out when navigating between
/// pages.
class FadePage<T> extends CustomTransitionPage<T> {
  FadePage({
    required super.child,
    super.transitionDuration,
    super.maintainState = true,
    super.fullscreenDialog = false,
    super.opaque = true,
    super.barrierDismissible = false,
    super.barrierColor,
    super.barrierLabel,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  }) : super(
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return FadeTransition(opacity: animation, child: child);
         },
       );
}
