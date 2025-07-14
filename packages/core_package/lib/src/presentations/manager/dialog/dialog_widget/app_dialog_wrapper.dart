import 'package:core_package/src/presentations/manager/dialog/dialog_manager.dart';
import 'package:flutter/material.dart';

class AppDialogWrapper extends StatelessWidget {
  final DialogConfig config;
  final VoidCallback? closePopup;

  const AppDialogWrapper({super.key, required this.config, this.closePopup});

  @override
  Widget build(BuildContext context) {
    final child = config.request?.dialogBuilder?.call(
      context,
      config,
      closePopup,
    );

    return child ?? const SizedBox();
  }
}
