import 'package:flutter/material.dart';
import 'package:ln_dialogs/ln_dialogs.dart';

class GeneralDialog extends StatelessWidget {
  final String title;
  final Function()? onCancel;
  final EdgeInsets padding;
  final Color? headerBackgroundColor;
  final bool? shrinkWrap;
  final AlignmentGeometry? alignment;
  final Widget content;
  final ThemeData? theme;
  final double maxWidth;

  const GeneralDialog({
    super.key,
    required this.title,
    required this.content,
    this.onCancel,
    this.padding = const EdgeInsets.all(24),
    this.headerBackgroundColor,
    this.shrinkWrap,
    this.alignment,
    this.theme,
    this.maxWidth = maxDialogWidth,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    Function()? onCancel,
    EdgeInsets padding = const EdgeInsets.all(24),
    Color? headerBackgroundColor,
    bool? shrinkWrap,
    AlignmentGeometry? alignment,
    ThemeData? theme,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GeneralDialog(
        title: title,
        content: content,
        onCancel: () {
          Navigator.of(context).pop(null);
          onCancel?.call();
        },
        padding: padding,
        headerBackgroundColor: headerBackgroundColor,
        shrinkWrap: shrinkWrap,
        alignment: alignment,
        theme: theme,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialog = AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: padding,
      buttonPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      title: DialogHeader(
        title: title,
        onTapClose: onCancel,
        backgroundColor: headerBackgroundColor,
      ),
      content: Container(
        width: maxDialogWidth,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: content,
      ),
    );
    return theme != null
        ? Theme(
            data: theme as ThemeData,
            child: dialog,
          )
        : dialog;
  }
}
