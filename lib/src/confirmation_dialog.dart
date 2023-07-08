import 'package:flutter/material.dart';
import 'package:ln_dialogs/ln_dialogs.dart';

class ConfirmationDialog extends AlertDialog {
  ConfirmationDialog({
    required BuildContext context,
    super.key,
    String? title,
    required String message,
    Function()? onSubmit,
    Function()? onCancel,
    double maxWidth = maxDialogWidth,
  }) : super(
          title: title != null ? Text(title) : null,
          content: SizedBox(
            width: maxDialogWidth,
            child: Text(message),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
              onPressed: () {
                Navigator.of(context).pop<bool>(true);
                onSubmit?.call();
              },
            ),
            TextButton(
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
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
    Function()? onSubmit,
    Function()? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationDialog(
        context: context,
        title: title,
        message: message,
        onSubmit: onSubmit,
        onCancel: onCancel,
      ),
    ).then((value) => value ?? false);
  }
}
