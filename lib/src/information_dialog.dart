import 'package:flutter/material.dart';
import 'package:ln_dialogs/ln_dialogs.dart';

class InformationDialog extends AlertDialog {
  InformationDialog({
    super.key,
    required BuildContext context,
    String? title,
    required String message,
    Function()? onClose,
    double maxWidth = maxDialogWidth,
  }) : super(
          title: title == null ? null : Text(title),
          content: SizedBox(
            width: maxDialogWidth,
            child: Text(message),
          ),
          actions: <Widget>[
            if (onClose != null)
              TextButton(
                onPressed: onClose,
                child: Text(MaterialLocalizations.of(context).okButtonLabel),
              ),
          ],
        );

  static Future<void> show({
    required BuildContext context,
    String? title,
    required String message,
    Function()? onClose,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => InformationDialog(
        context: context,
        title: title,
        message: message,
        onClose: () {
          Navigator.of(context).pop();
          onClose?.call();
        },
      ),
    );
  }
}
