import 'package:flutter/material.dart';

typedef BottomSheetBody =
    Widget Function(
      BuildContext context,
      DraggableScrollableController? draggableScrollableController,
      ScrollController? scrollController,
    );

class BottomSheetManager {
  const BottomSheetManager();

  Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required BottomSheetBody body,
    bool isScrollControlled = false,
    bool dragOnScroll = true,
    bool expandedScroll = false,
    bool isDismissible = true,
    bool enableDrag = true,
    double? maxChildSize,
    double? initialChildSizeWithScrollControlled,
    Color? barrierColor,
    VoidCallback? onClose,
  }) {
    final draggableScrollableController = DraggableScrollableController();

    FocusManager.instance.primaryFocus?.unfocus();

    return showModalBottomSheet<T>(
      context: context,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      barrierColor: barrierColor ?? Colors.black.withOpacity(0.8),
      builder: (context) {
        if (dragOnScroll && isScrollControlled) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: isDismissible ? () => Navigator.pop(context) : null,
            child: DraggableScrollableSheet(
              initialChildSize: initialChildSizeWithScrollControlled ?? 0.6,
              // half screen on load
              maxChildSize: maxChildSize ?? (expandedScroll ? 1 : 0.9),
              // full screen on scroll
              minChildSize: 0.25,
              controller: draggableScrollableController,
              builder: (
                BuildContext context,
                ScrollController scrollController,
              ) {
                return body(
                  context,
                  draggableScrollableController,
                  scrollController,
                );
              },
            ),
          );
        }

        return body(context, null, null);
      },
    ).whenComplete(() {
      onClose?.call();
      //draggableScrollableController.dispose();
    });
  }
}
