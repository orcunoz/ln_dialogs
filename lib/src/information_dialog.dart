import 'package:flutter/material.dart';
import 'package:ln_core/ln_core.dart';
import 'package:ln_dialogs/ln_dialogs.dart';

class InformationDialog extends AlertDialog {
  InformationDialog({
    super.key,
    required BuildContext context,
    String? title,
    required String message,
    double maxWidth = maxDialogWidth,
  }) : super(
          title: title == null ? null : Text(title),
          content: SizedBox(
            width: maxDialogWidth,
            child: Text(message),
          ),
          actions: <Widget>[
            LnDialogButton.close(
              text: LnLocalizations.current.ok,
            ),
          ],
        );

  static Future<void> show({
    required BuildContext context,
    String? title,
    required String message,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => InformationDialog(
        context: context,
        title: title,
        message: message,
      ),
    );
  }
}
