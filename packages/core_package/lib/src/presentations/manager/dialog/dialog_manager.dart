import 'dart:async';
import 'dart:collection';
import 'package:core_package/src/presentations/manager/dialog/dialog_widget/app_dialog_wrapper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/// Defines the different types of dialogs available in the application.
enum DialogType { refresh, confirm, warning, expired, error }

/// A high-level wrapper for DialogManager providing simplified interface for showing dialogs.
///
/// This class abstracts away the complexity of the underlying DialogManager and provides
/// a more convenient API for showing dialogs in the application.
final class BaseDialogManager {
  late final DialogManager _dialogManager;

  /// Creates a BaseDialogManager and initializes the underlying DialogManager.
  BaseDialogManager() {
    _init();
  }

  /// Shows a dialog with the specified configuration.
  ///
  /// [context] - BuildContext where the dialog will be shown.
  /// [dialogBuilder] - The builder function that creates the dialog content.
  /// [dialogType] - The type of dialog to show (defaults to DialogType.confirm).
  /// [barrierDismissible] - Whether the dialog can be dismissed by tapping outside (defaults to false).
  void show({
    required BuildContext context,
    required DialogBuilder dialogBuilder,
    DialogType dialogType = DialogType.confirm,
    bool barrierDismissible = false,
  }) {
    final config = DialogConfig(
      type: dialogType.name,
      barrierDismissible: barrierDismissible,
      completer: Completer(),
      request: DialogRequest(dialogBuilder: dialogBuilder),
    );

    _dialogManager.show(context, config: config);
  }

  /// Initialize the DialogManager with appropriate dialog builders.
  void _init() {
    _dialogManager = DialogManager();
    final dialogBuilders = <String, DialogBuilder>{
      for (final type in DialogType.values) type.name: _dialogBuilder(),
    };

    _dialogManager.registerDialogBuilder(dialogBuilders);
  }

  /// Creates a default dialog builder that uses AppDialogWrapper.
  DialogBuilder _dialogBuilder() {
    return (
      BuildContext context,
      DialogConfig config,
      VoidCallback? closePopup,
    ) => AppDialogWrapper(config: config, closePopup: closePopup);
  }
}

/// Type definition for a function that modifies a dialog request.
typedef ListenDialog = DialogRequest Function(DialogRequest);

/// Type definition for a function that builds a dialog widget.
///
/// [context] - The build context.
/// [config] - The dialog configuration.
/// [closePopup] - Optional callback to close the dialog.
typedef DialogBuilder =
    Widget Function(
      BuildContext context,
      DialogConfig config,
      VoidCallback? closePopup,
    );

/// Manages the display of dialogs in the application with a queue system.
///
/// This class handles showing dialogs in a controlled manner, ensuring that
/// only one dialog is displayed at a time, with others queued up to be shown
/// when the current dialog is dismissed.
final class DialogManager {
  /// Queue of dialogs waiting to be shown.
  final Queue<({BuildContext context, DialogConfig config})> _queue = Queue();

  /// Stream that processes dialog display requests in order.
  final BehaviorSubject<({BuildContext context, DialogConfig config})>
  _dialogProcess = BehaviorSubject();

  /// Map of registered dialog builders indexed by dialog type.
  final Map<String, DialogBuilder> _dialogsBuilder = {};

  /// Maximum number of dialogs that can be shown simultaneously.
  final int maxConcurrent = 1;

  /// Current number of dialogs being shown.
  int currentShownCount = 0;

  /// Creates a new DialogManager instance.
  DialogManager();

  /// Registers dialog builders that will be used to create dialogs.
  ///
  /// [builders] - A map where keys are dialog types and values are the corresponding builders.
  void registerDialogBuilder(Map<String, DialogBuilder> builders) {
    _dialogsBuilder.addAll(builders);
    _dialogProcess
        .delay(const Duration(milliseconds: 200))
        .distinct(
          (previous, next) => _compareDialog(previous.config, next.config),
        )
        .listen((dialog) {
          debugPrint(currentShownCount.toString());
          if (currentShownCount < maxConcurrent) {
            _showDialog(dialog.context, dialog.config);
          }
        });
  }

  /// Shows a dialog with the given configuration.
  ///
  /// Adds the dialog to the queue if necessary and triggers the dialog process.
  ///
  /// [context] - BuildContext where the dialog will be shown.
  /// [config] - Configuration for the dialog to be displayed.
  void show(BuildContext context, {required DialogConfig config}) {
    final packDialog = (context: context, config: config);
    if (!_queue.any(
      (element) => _compareDialog(element.config, packDialog.config),
    )) {
      debugPrint('Dialog: add to queue');
      _queue.addLast(packDialog);
    }

    if (!_dialogProcess.hasValue ||
        _dialogProcess.value.config.completer.isCompleted) {
      debugPrint('Dialog: handling case 1');
      _dialogProcess.add(_queue.removeFirst());
    } else if (_dialogProcess.hasValue &&
        !_dialogProcess.value.config.completer.isCompleted) {
      debugPrint('Dialog: handling case 2');

      if (_queue.isNotEmpty) {
        _dialogProcess.add(_queue.removeFirst());
      } else {
        _dialogProcess.add(packDialog);
      }
    }

    config.completer.future.whenComplete(() {
      debugPrint('Dialog: isCompleted');
      _resetCount();
      if (_queue.isNotEmpty) {
        _dialogProcess.add(_queue.removeFirst());
      } else {
        debugPrint('Dialog: reset');
        _dialogProcess.add((
          context: context,
          config: DialogConfig(type: '_', completer: Completer()),
        ));
      }
    });
  }

  /// Resets the count of currently shown dialogs.
  void _resetCount() {
    currentShownCount = 0;
  }

  /// Compares two dialog configurations to determine if they're the same.
  ///
  /// Used to prevent duplicate dialogs from being queued.
  bool _compareDialog(DialogConfig a, DialogConfig b) {
    if (a.type == b.type) {
      if (a.request?.title == b.request?.title &&
          a.request?.description == b.request?.description) {
        return true;
      }
    }
    return false;
  }

  /// Shows a dialog using the specified configuration.
  ///
  /// Uses the registered dialog builder matching the config's type to create the dialog.
  void _showDialog(BuildContext context, DialogConfig config) {
    debugPrint('Dialog: show');

    final dialog = _dialogsBuilder[config.type];
    if (dialog != null) {
      currentShownCount++;
      showDialog<void>(
        context: context,
        barrierDismissible: config.barrierDismissible,
        barrierColor: config.barrierColor,
        builder: (_) {
          void closePopup() => _onPopupClose(
            context,
            config.completer,
            config.barrierDismissible,
          );
          return PopScope(
            canPop: config.barrierDismissible,
            onPopInvokedWithResult: (didPop, _) {
              if (config.barrierDismissible) {
                config.request?.onClose?.call();
                config.completer.complete();
              }
            },
            child: dialog.call(context, config, closePopup),
          );
        },
      );
    } else {
      config.completer.complete();
    }
  }

  /// Handles dialog closure by popping the dialog and completing its completer.
  ///
  /// [context] - The context of the dialog.
  /// [completer] - The completer to be completed when dialog is closed.
  /// [barrierDismissible] - Whether the dialog can be dismissed by tapping outside.
  void _onPopupClose(
    BuildContext context,
    Completer completer,
    bool barrierDismissible,
  ) {
    Navigator.pop(context);
    if (!completer.isCompleted) {
      completer.complete();
    }
  }

  /// Closes all dialogs and cleans up resources.
  void close() {
    _queue.clear();
    _dialogProcess.close();
  }
}

/// Represents a request to show a dialog with specific content and behavior.
class DialogRequest extends Equatable {
  /// Title of the dialog.
  final String? title;

  /// Description or main content of the dialog.
  final dynamic description;

  /// Optional icon to display in the dialog.
  final Widget? icon;

  /// Title for the main/primary button.
  final String? mainButtonTitle;

  /// Title for the secondary button.
  final String? secondaryButtonTitle;

  /// Callback executed when the main button is tapped.
  final VoidCallback? onMainButtonTap;

  /// Callback executed when the secondary button is tapped.
  final VoidCallback? onSecondaryButtonTap;

  /// Callback executed when the dialog is closed.
  final VoidCallback? onClose;

  /// Builder function to create the dialog content.
  final DialogBuilder? dialogBuilder;

  /// Creates a new DialogRequest with the specified properties.
  const DialogRequest({
    this.description,
    this.onMainButtonTap,
    this.mainButtonTitle,
    this.secondaryButtonTitle,
    this.onSecondaryButtonTap,
    this.onClose,
    this.title,
    this.icon,
    this.dialogBuilder,
  });

  @override
  List get props => [description, title];
}

/// Configuration for a dialog to be displayed.
final class DialogConfig extends Equatable {
  /// Whether the dialog can be dismissed by tapping outside.
  final bool barrierDismissible;

  /// Request object containing dialog content and callbacks.
  final DialogRequest? request;

  /// Completer that will be completed when the dialog is closed.
  final Completer completer;

  /// Type of the dialog, used to find the appropriate builder.
  final String type;

  /// Color of the barrier/overlay behind the dialog.
  final Color? barrierColor;

  /// Theme configuration for the dialog.
  final DialogTheme dialogTheme;

  /// Creates a new DialogConfig with the specified properties.
  const DialogConfig({
    required this.type,
    required this.completer,
    this.dialogTheme = const DialogTheme(
      insetAnimationDuration: Duration(milliseconds: 100),
      insetPadding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      insetAnimationCurve: Curves.decelerate,
      clipBehavior: Clip.none,
    ),
    this.barrierDismissible = true,
    this.request,
    this.barrierColor = Colors.black38,
  });

  @override
  List get props => [request, type];
}

/// Theme configuration for dialogs.
final class DialogTheme {
  /// Background color of the dialog.
  final Color? backgroundColor;

  /// Elevation of the dialog.
  final double? elevation;

  /// Color of the dialog's shadow.
  final Color? shadowColor;

  /// Surface tint color of the dialog.
  final Color? surfaceTintColor;

  /// Duration of the animation when the dialog appears.
  final Duration? insetAnimationDuration;

  /// Curve of the animation when the dialog appears.
  final Curve? insetAnimationCurve;

  /// Padding around the dialog.
  final EdgeInsets? insetPadding;

  /// How to clip the dialog's content.
  final Clip? clipBehavior;

  /// Shape of the dialog's border.
  final ShapeBorder? shape;

  /// Alignment of the dialog within the screen.
  final AlignmentGeometry? alignment;

  /// Creates a new DialogTheme with the specified properties.
  const DialogTheme({
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.insetAnimationDuration,
    this.insetAnimationCurve,
    this.insetPadding,
    this.clipBehavior,
    this.shape,
    this.alignment,
  });
}
