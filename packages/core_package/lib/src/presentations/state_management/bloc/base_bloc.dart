import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'base_event.dart';

part 'base_state.dart';

/// > BaseBloc is an abstract class that extends Bloc and takes two generic types: T
/// extends BaseEvent and BaseState
abstract class BaseBloc<T extends BaseEvent, S extends BaseBlocState>
    extends Bloc<T, S> with WidgetsBindingObserver, RouteAware {
  late bool _isMounted;

  BaseBloc(super.initialState) {
    _isMounted = true;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isMounted) {
      switch (state) {
        case AppLifecycleState.inactive:
          onInActive();
          break;
        case AppLifecycleState.paused:
          onPaused();
          break;
        case AppLifecycleState.resumed:
          onResumed();
          break;
        case AppLifecycleState.detached:
          onDetached();
          break;
        case AppLifecycleState.hidden:
          onHidden();
          break;
      }
    }
  }

  @override
  Future<void> close() {
    _isMounted = false;
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  void onInActive() {}

  void onPaused() {}

  void onResumed() {}

  void onDetached() {}

  void onHidden() {}
}
