import 'package:core_package/src/presentations/manager/dialog/dialog_manager.dart';
import 'package:core_package/src/presentations/manager/loading/loading_manager.dart';
import 'package:core_package/src/presentations/manager/manager.dart';

final class AppController {
  final LoadingManager _loadingManager;
  final BaseDialogManager _dialogManager;
  final ToastManager _toastManager;
  final BottomSheetManager _bottomSheetManager;

  AppController()
    : _loadingManager = LoadingManager(),
      _dialogManager = BaseDialogManager(),
      _bottomSheetManager = const BottomSheetManager(),
      _toastManager = const ToastManager();

  LoadingManager get loading => _loadingManager;

  BaseDialogManager get dialog => _dialogManager;

  BottomSheetManager get bottomSheet => _bottomSheetManager;

  ToastManager get toast => _toastManager;
}

final appController = AppController();
