import 'package:core_package/src/presentations/state_management/bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState();
}

abstract class BaseScreenState<
  P extends StatefulWidget,
  E extends BaseEvent,
  S extends BaseBlocState,
  T extends BaseBloc<E, S>
>
    extends State<P>
    with AutomaticKeepAliveClientMixin {
  /// Getting the instance of the BLoC.
  T get bloc => GetIt.I<T>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initBloc();
    });
  }

  /// > It resets the lazy singleton of type T
  @override
  void dispose() {
    if (!wantKeepBloc) {
      GetIt.I.resetLazySingleton<T>();
    }
    super.dispose();
  }

  /// A method that is called in the `initState` method.
  void initBloc();

  /// A getter that is used to determine whether the state of the widget should be
  /// kept alive.
  @override
  bool get wantKeepAlive => false;

  bool get wantKeepBloc => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<T, S>(
        bloc: bloc,
        listener: listenerBloc,
        listenWhen: listenWhen,
        buildWhen: buildWhen,
        builder: (context, state) {
          return buildMobile(context, state);
        },
      ),
    );
  }

  void listenerBloc(BuildContext context, S state) {}

  bool buildWhen(S previous, S current) => previous != current;

  bool listenWhen(S previous, S current) => true;

  Widget buildMobile(BuildContext context, S state);

  Widget buildTablet(BuildContext context, S state) {
    return buildMobile(context, state);
  }

  Widget buildLandscapeMobile(BuildContext context, S state) {
    return buildMobile(context, state);
  }

  Widget buildLandscapeTablet(BuildContext context, S state) {
    return buildTablet(context, state);
  }
}

mixin BaseBuildScreenStateMixin on BaseScreenState {}
