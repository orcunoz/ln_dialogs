import 'package:flutter/material.dart';
import 'package:ln_dialogs/ln_dialogs.dart';

class GeneralDialog extends AlertDialog {
  GeneralDialog({
    super.key,
    String? title,
    required Widget? content,
    Function()? onCancel,
    EdgeInsets padding = const EdgeInsets.all(24),
    Color? headerBackgroundColor,
    super.alignment,
  }) : super(
          title: _buildTitle(title, headerBackgroundColor, onCancel),
          contentPadding: EdgeInsets.zero,
          insetPadding: padding,
          buttonPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          actionsPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          content: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: maxDialogWidth),
            child: content,
          ),
        );

  static Widget? _buildTitle(
    String? title,
    Color? backgroundColor,
    Function()? onCancel,
  ) =>
      title == null
          ? null
          : DialogHeader(
              title: title,
              onTapClose: onCancel,
              backgroundColor: backgroundColor,
            );

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget? content,
    EdgeInsets padding = const EdgeInsets.all(24),
    Color? headerBackgroundColor,
    AlignmentGeometry? alignment,
    Function()? onCancel,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GeneralDialog(
        title: title,
        content: content,
        padding: padding,
        headerBackgroundColor: headerBackgroundColor,
        alignment: alignment,
        onCancel: () {
          Navigator.of(context).pop(null);
          onCancel?.call();
        },
      ),
    );
  }
}
