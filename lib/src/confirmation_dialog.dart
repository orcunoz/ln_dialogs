import 'package:flutter/material.dart';
import 'package:ln_dialogs/ln_dialogs.dart';

class ConfirmationDialog extends AlertDialog {
  ConfirmationDialog({
    required BuildContext context,
    super.key,
    String? title,
    required String message,
    String? submitButtonText,
    void Function()? onSubmit,
    String? cancelButtonText,
    void Function()? onCancel,
    double maxWidth = maxDialogWidth,
  }) : super(
          title: title != null ? Text(title) : null,
          content: SizedBox(
            width: maxDialogWidth,
            child: Text(message),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(submitButtonText ??
                  MaterialLocalizations.of(context).okButtonLabel),
              onPressed: () {
                Navigator.of(context).pop<bool>(true);
                onSubmit?.call();
              },
            ),
            TextButton(
              child: Text(cancelButtonText ??
                  MaterialLocalizations.of(context).cancelButtonLabel),
              onPressed: () {
                Navigator.of(context).pop<bool>(false);
                onCancel?.call();
              },
            ),
          ],
        );

  static Future<bool> show({
    required BuildContext context,
    String? title,
    required String message,
    String? submitButtonText,
    void Function()? onSubmit,
    String? cancelButtonText,
    void Function()? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationDialog(
        context: context,
        title: title,
        message: message,
        submitButtonText: submitButtonText,
        onSubmit: onSubmit,
        cancelButtonText: cancelButtonText,
        onCancel: onCancel,
      ),
    ).then((value) => value ?? false);
  }
}
