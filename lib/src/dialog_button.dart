import 'package:flutter/material.dart';
import 'package:ln_core/ln_core.dart';

enum DialogActions { confirm, reject, close }

class LnDialogButton extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final Set<DialogActions> actions;

  const LnDialogButton({
    this.text,
    this.onPressed,
    this.actions = const {},
  });
  const LnDialogButton.close({
    this.text,
    this.onPressed,
    this.actions = const {DialogActions.close},
  });
  const LnDialogButton.confirm({
    this.text,
    this.onPressed,
    this.actions = const {DialogActions.confirm, DialogActions.close},
  });
  const LnDialogButton.reject({
    this.text,
    this.onPressed,
    this.actions = const {DialogActions.reject, DialogActions.close},
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (actions.contains(DialogActions.close)) {
          bool? value = actions.contains(DialogActions.confirm)
              ? true
              : actions.contains(DialogActions.reject)
                  ? false
                  : null;
          Navigator.of(context).pop<bool>(value);
        }
        onPressed?.call();
      },
      child: Text(text ?? _defaultText()),
    );
  }

  String _defaultText() {
    if (actions.contains(DialogActions.confirm)) {
      return LnLocalizations.current.confirm;
    } else if (actions.contains(DialogActions.reject)) {
      return LnLocalizations.current.reject;
    } else if (actions.contains(DialogActions.close)) {
      return LnLocalizations.current.close;
    }

    return LnLocalizations.current.ok;
  }
}
