import 'dart:async';

import 'package:flutter/material.dart';

enum ToastDirection { fromBottom, fromTop }

typedef TopToastBuilder = WidgetBuilder;
typedef BottomToastBuilder = WidgetBuilder;

class ToastManager {
  const ToastManager();

  void showTopToast({
    required BuildContext context,
    String? message,
    String? title,
    TopToastBuilder? toastBuilder,
    VoidCallback? onDismiss,
  }) {
    _showToast(
      context: context,
      message: message,
      title: title,
      direction: ToastDirection.fromTop,
      topToastBuilder: toastBuilder,
      onClose: onDismiss,
    );
  }

  void showBottomToast({
    required BuildContext context,
    String? message,
    String? title,
    BottomToastBuilder? toastBuilder,
    VoidCallback? onClose,
  }) {
    _showToast(
      context: context,
      message: message,
      title: title,
      direction: ToastDirection.fromBottom,
      onClose: onClose,
      bottomToastBuilder: toastBuilder,
    );
  }

  void _showToast({
    required BuildContext context,
    String? message,
    String? title,
    ToastDirection direction = ToastDirection.fromBottom,
    Duration? toastDuration,
    TopToastBuilder? topToastBuilder,
    BottomToastBuilder? bottomToastBuilder,
    VoidCallback? onClose,
  }) {
    switch (direction) {
      case ToastDirection.fromBottom:
        final scaffold = ScaffoldMessenger.of(context);
        final paddingBottom = MediaQuery.of(context).padding.bottom;
        Future(
          () => scaffold.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: paddingBottom != 0 ? paddingBottom : 16,
              ),
              duration: toastDuration ?? const Duration(milliseconds: 3000),
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              dismissDirection: DismissDirection.endToStart,
              content:
                  bottomToastBuilder?.call(context) ??
                  _DefaultToast(message: message),
            ),
          ),
        ).whenComplete(() => onClose);
        break;
      case ToastDirection.fromTop:
        final overlay = Overlay.of(context);
        final snackBar = QueueSnackBar();
        snackBar.showSnackBar(
          overlay,
          displayDuration: toastDuration ?? const Duration(seconds: 1),
          child:
              topToastBuilder?.call(context) ?? _DefaultToast(message: message),
          onClose: onClose,
        );
        break;
    }
  }

  void showCustomBottomToast({
    required BuildContext context,
    required SnackBar snackBar,
    ToastDirection direction = ToastDirection.fromBottom,
  }) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(snackBar);
  }
}

typedef ControllerCallback = void Function(AnimationController);

enum DismissType { onTap, onSwipe, none }

class QueueSnackBar {
  OverlayEntry? _previousEntry;

  /// The [overlayState] argument is used to add specific overlay state.
  /// If you are sure that there is a overlay state in your [BuildContext],
  /// You can get it [Overlay.of(BuildContext)]
  /// Displays a widget that will be passed to [child] parameter above the current
  /// contents of the app, with transition animation
  ///
  /// The [child] argument is used to pass widget that you want to show
  ///
  /// The [forwardDuration] argument is used to specify duration of
  /// enter transition
  ///
  /// The [reverseDuration] argument is used to specify duration of
  /// exit transition
  ///
  /// The [displayDuration] argument is used to specify duration displaying
  ///
  /// The [onTap] callback of [_TopSnackBar]
  ///
  /// The [persistent] argument is used to make snack bar persistent, so
  /// [displayDuration] will be ignored. Default is false.
  ///
  /// The [onAnimationControllerInit] callback is called on internal
  /// [AnimationController] has been initialized.
  ///
  /// The [padding] argument is used to specify amount of outer padding
  ///
  /// [curve] and [reverseCurve] arguments are used to specify curves
  /// for in and out animations respectively
  ///
  /// The [safeAreaValues] argument is used to specify the arguments of the
  /// [SafeArea] widget that wrap the snackbar.
  ///
  /// The [dismissType] argument specify which action to trigger to
  /// dismiss the snackbar. Defaults to `TopSnackBarDismissType.onTap`
  ///
  /// The [dismissDirection] argument specify in which direction the snackbar
  /// can be dismissed. This argument is only used when [dismissType] is equal
  /// to `DismissType.onSwipe`. Defaults to `[DismissDirection.up]`
  void showSnackBar(
    OverlayState overlayState, {
    required Widget child,
    Duration forwardDuration = const Duration(milliseconds: 350),
    Duration reverseDuration = const Duration(milliseconds: 150),
    Duration displayDuration = const Duration(milliseconds: 3000),
    VoidCallback? onTap,
    bool persistent = false,
    ControllerCallback? onAnimationControllerInit,
    EdgeInsets padding = const EdgeInsets.all(16),
    Curve? curve,
    Curve? reverseCurve,
    DismissType dismissType = DismissType.onTap,
    List<DismissDirection> dismissDirection = const [DismissDirection.up],
    VoidCallback? onClose,
  }) {
    if (_previousEntry != null && _previousEntry!.mounted) {
      _previousEntry?.remove();
    }

    late final OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (_) {
        return _TopSnackBar(
          onDismissed: () {
            overlayEntry.remove();
            _previousEntry = null;
            onClose?.call();
          },
          forwardDuration: forwardDuration,
          reverseDuration: reverseDuration,
          displayDuration: displayDuration,
          onTap: onTap,
          persistent: persistent,
          onAnimationControllerInit: onAnimationControllerInit,
          padding: padding,
          curve: curve ?? Curves.easeOutQuint,
          reverseCurve: reverseCurve ?? Curves.easeOutCirc,
          dismissType: dismissType,
          dismissDirections: dismissDirection,
          child: child,
        );
      },
    );

    overlayState.insert(overlayEntry);
    _previousEntry = overlayEntry;
  }
}

/// Widget that controls all animations
class _TopSnackBar extends StatefulWidget {
  const _TopSnackBar({
    required this.child,
    required this.onDismissed,
    required this.forwardDuration,
    required this.reverseDuration,
    required this.displayDuration,
    required this.padding,
    required this.curve,
    required this.reverseCurve,
    required this.dismissDirections,
    this.onTap,
    this.persistent = false,
    this.onAnimationControllerInit,
    this.dismissType = DismissType.onTap,
  });

  final Widget child;
  final VoidCallback onDismissed;
  final Duration forwardDuration;
  final Duration reverseDuration;
  final Duration displayDuration;
  final VoidCallback? onTap;
  final ControllerCallback? onAnimationControllerInit;
  final bool persistent;
  final EdgeInsets padding;
  final Curve curve;
  final Curve reverseCurve;
  final DismissType dismissType;
  final List<DismissDirection> dismissDirections;

  @override
  _TopSnackBarState createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<_TopSnackBar>
    with SingleTickerProviderStateMixin {
  late final Animation<Offset> _offsetAnimation;
  late final AnimationController _animationController;

  Timer? _timer;

  final _offsetTween = Tween(begin: const Offset(0, -1), end: Offset.zero);

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.forwardDuration,
      reverseDuration: widget.reverseDuration,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && !widget.persistent) {
        _timer = Timer(widget.displayDuration, () {
          if (mounted) {
            _animationController.reverse();
          }
        });
      }
      if (status == AnimationStatus.dismissed) {
        _timer?.cancel();
        widget.onDismissed.call();
      }
    });

    widget.onAnimationControllerInit?.call(_animationController);

    _offsetAnimation = _offsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve,
      ),
    );
    if (mounted) {
      _animationController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.padding.top,
      left: widget.padding.left,
      right: widget.padding.right,
      child: SlideTransition(
        position: _offsetAnimation,
        child: SafeArea(child: _buildDismissibleChild()),
      ),
    );
  }

  /// Build different type of [Widget] depending on [DismissType] value
  Widget _buildDismissibleChild() {
    switch (widget.dismissType) {
      case DismissType.onTap:
        return AnimatedBounce(
          onTap: () {
            widget.onTap?.call();
            if (!widget.persistent && mounted) {
              _animationController.reverse();
            }
          },
          child: Material(color: Colors.transparent, child: widget.child),
        );
      case DismissType.onSwipe:
        var childWidget = widget.child;
        for (final direction in widget.dismissDirections) {
          childWidget = Dismissible(
            direction: direction,
            key: UniqueKey(),
            dismissThresholds: const {DismissDirection.up: 0.2},
            confirmDismiss: (direction) async {
              if (!widget.persistent && mounted) {
                if (direction == DismissDirection.down) {
                  await _animationController.reverse();
                } else {
                  _animationController.reset();
                }
              }
              return false;
            },
            child: childWidget,
          );
        }
        return Material(color: Colors.transparent, child: childWidget);
      case DismissType.none:
        return Material(color: Colors.transparent, child: widget.child);
    }
  }
}

class AnimatedBounce extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const AnimatedBounce({super.key, required this.child, this.onTap});

  @override
  State<AnimatedBounce> createState() => _AnimatedBounceState();
}

class _AnimatedBounceState extends State<AnimatedBounce>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  final duration = const Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: duration,
      upperBound: 0.05,
    )..addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: (_) async => await _close(),
      onPanEnd: (_) async => await _close(),
      child: Transform.scale(scale: 1 - controller.value, child: widget.child),
    );
  }

  void _onTapDown(TapDownDetails details) {
    if (mounted) {
      controller.forward();
    }
  }

  Future<void> _close() async {
    if (mounted) {
      unawaited(controller.forward().whenComplete(() => controller.reverse()));
      await Future.delayed(const Duration(milliseconds: 150));
      widget.onTap?.call();
    }
  }
}

class _DefaultToast extends StatelessWidget {
  final String? message;

  const _DefaultToast({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Colors.white,
        border: Border.all(color: Colors.teal),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message ?? "Message",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.info_outline, color: Colors.teal[400], size: 24),
        ],
      ),
    );
  }
}
