import 'package:flutter/material.dart';
import 'package:ln_dialogs/ln_dialogs.dart';

import 'dart:math';

class BottomSheetDialog extends StatelessWidget {
  const BottomSheetDialog({
    super.key,
    required this.body,
    this.title,
    this.headerForegroundColor,
    this.headerBackgroundColor,
    this.onTapClose,
  });

  final Widget body;
  final String? title;
  final Function()? onTapClose;
  final Color? headerForegroundColor;
  final Color? headerBackgroundColor;

  static Future show({
    required BuildContext context,
    required WidgetBuilder builder,
    String? title,
    Color? headerForegroundColor,
    Color? headerBackgroundColor,
    bool showCloseButton = true,
    Color barrierColor = Colors.transparent,
    Duration? animationDuration,
    double? heightFactor,
    double? height,
  }) {
    assert(height == null || heightFactor == null);

    if (height != null) {
      heightFactor = min(height / (MediaQuery.of(context).size.height), 1.0);
    }

    var curveTween = CurveTween(curve: Curves.ease);

    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "BottomSheetDialogLabel",
      barrierColor: barrierColor,
      transitionBuilder: (context, a1, a2, widget) => Transform.translate(
        offset: Offset(0, (1 - curveTween.transform(a1.value)) * 1000),
        child: widget,
      ),
      transitionDuration:
          animationDuration ?? const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) {
        var child = BottomSheetDialog(
          body: builder(context),
          title: title,
          headerForegroundColor: headerForegroundColor,
          headerBackgroundColor: headerBackgroundColor,
          onTapClose:
              showCloseButton ? () => Navigator.of(context).pop() : null,
        );

        return heightFactor == null
            ? child
            : FractionallySizedBox(
                heightFactor: heightFactor,
                alignment: Alignment.bottomCenter,
                child: child,
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var header = title == null && onTapClose == null
        ? null
        : DialogHeader(
            title: title ?? "",
            foregroundColor: headerForegroundColor,
            backgroundColor: headerBackgroundColor,
            onTapClose: onTapClose,
          );
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: header == null
            ? body
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  header,
                  Expanded(child: body),
                ],
              ),
      ),
    );
  }
}
