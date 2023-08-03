import 'package:flutter/material.dart';
import 'package:ln_dialogs/ln_dialogs.dart';

class ConfirmationDialog extends AlertDialog {
  ConfirmationDialog({
    required BuildContext context,
    super.key,
    String? title,
    required String message,
    LnDialogButton confirmButton = const LnDialogButton.confirm(),
    LnDialogButton rejectButton = const LnDialogButton.reject(),
    double maxWidth = maxDialogWidth,
  }) : super(
          title: title != null ? Text(title) : null,
          content: SizedBox(
            width: maxDialogWidth,
            child: Text(message),
          ),
          actions: <Widget>[
            confirmButton,
            rejectButton,
          ],
        );

  static Future<bool> show({
    required BuildContext context,
    String? title,
    required String message,
    LnDialogButton confirmButton = const LnDialogButton.confirm(),
    LnDialogButton rejectButton = const LnDialogButton.reject(),
  }) =>
      showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ConfirmationDialog(
          context: context,
          title: title,
          message: message,
          confirmButton: confirmButton,
          rejectButton: rejectButton,
        ),
      ).then((value) => value ?? false);
}
