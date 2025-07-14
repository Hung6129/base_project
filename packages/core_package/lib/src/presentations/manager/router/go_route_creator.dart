import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// A function that returns a widget.
typedef CreatorBuilder = Widget Function(BuildContext context, Object);

/// Used to create a `Page` from a `GoRoute`.
typedef CreatorPageBuilder = Page<void> Function(BuildContext context, Object);

/// `CreatorRedirect` is used to redirect to another route.
typedef CreatorRedirect = FutureOr<String?> Function(Object data);

abstract class GoRouteCreator<T extends AppGoRouteData> {
  final CreatorBuilder? builder;

  final CreatorPageBuilder? pageBuilder;

  final CreatorRedirect? redirect;

  const GoRouteCreator({this.builder, this.pageBuilder, this.redirect});

  String $location(T data);

  T $fromState(GoRouterState state);

  GoRoute $route({
    required String path,
    String? name,
    GlobalKey<NavigatorState>? parentNavigatorKey,
    List<RouteBase> routes = const <RouteBase>[],
  }) {
    return GoRouteData.$route(
      path: path,
      name: name,
      parentNavigatorKey: parentNavigatorKey,
      factory: $fromState,
      routes: routes,
    );
  }
}

abstract class AppGoRouteData<T> extends GoRouteData {
  final ValueKey<String>? pageKey;

  final GoRouteCreator<AppGoRouteData<T>> creator;

  final T? extra;

  AppGoRouteData(this.creator, {this.pageKey, this.extra});

  String get location => creator.$location(this);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return creator.builder?.call(context, this) ?? super.build(context, state);
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return creator.pageBuilder?.call(context, this) ??
        super.buildPage(
          context,
          state,
        );
  }

  /// `go` is a method that is used to navigate to a route.
  void go(BuildContext context) => context.go(location, extra: this);

  /// Pushing a new route onto the stack.
  Future<E?> push<E>(BuildContext context) => context.push<E>(location, extra: this);

  /// Replacing the current route with the new route.
  void replace(BuildContext context) => context.pushReplacement(location, extra: this);

  /// Pop the current route.
  void pop<E extends Object?>(BuildContext context, [T? result]) => context.pop(result);

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    return creator.redirect?.call(this) ?? super.redirect(context, state);
  }
}

/// `NoOpPage` is a `Page` that is used when the `GoRouteCreator` does not have a
/// `pageBuilder`.
class NoOpPage extends Page<void> {
  const NoOpPage();

  @override
  Route<void> createRoute(BuildContext context) => throw UnsupportedError('Should never be called');
}
