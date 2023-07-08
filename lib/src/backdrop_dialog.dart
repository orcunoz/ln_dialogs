import 'package:flutter/material.dart';
import 'package:ln_dialogs/ln_dialogs.dart';

import 'dart:math';

class BackdropDialog extends StatelessWidget {
  final Widget body;
  final String? title;
  final Function()? onTapClose;
  final BorderRadius? headerBorderRadius;
  final Color? headerBackgroundColor;
  const BackdropDialog({
    super.key,
    required this.body,
    this.title,
    this.headerBackgroundColor,
    this.headerBorderRadius,
    this.onTapClose,
  });

  static Future show({
    required BuildContext context,
    required Widget body,
    String? title,
    Color? headerBackgroundColor,
    BorderRadius? headerBorderRadius,
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

    var child = BackdropDialog(
      body: body,
      title: title,
      headerBackgroundColor: headerBackgroundColor,
      headerBorderRadius: headerBorderRadius,
      onTapClose: showCloseButton ? () => Navigator.of(context).pop() : null,
    );

    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "BackdropDialogLabel",
      barrierColor: barrierColor,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.translate(
          offset: Offset(0, (1 - curveTween.transform(a1.value)) * 1000),
          child: widget,
        );
      },
      transitionDuration:
          animationDuration ?? const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) => heightFactor == null
          ? child
          : FractionallySizedBox(
              heightFactor: heightFactor,
              alignment: Alignment.bottomCenter,
              child: child,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var header = title == null && onTapClose == null
        ? null
        : DialogHeader(
            title: title ?? "",
            backgroundColor: headerBackgroundColor,
            borderRadius: headerBorderRadius,
            onTapClose: onTapClose,
          );
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: headerBorderRadius ??
            const BorderRadius.vertical(top: Radius.circular(16)),
        child: header == null
            ? body
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  header,
                  Expanded(
                    child: body,
                  ),
                ],
              ),
      ),
    );
  }
}