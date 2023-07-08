import 'package:flutter/material.dart';
import 'package:ln_core/ln_core.dart';

class DialogHeader extends StatelessWidget {
  final String title;
  final bool searchable;
  final Function(String)? onSearchTextChanged;
  final Function()? onTapClose;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderRadius? borderRadius;

  const DialogHeader({
    super.key,
    required this.title,
    this.searchable = false,
    this.onSearchTextChanged,
    this.onTapClose,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleForegroundColor =
        foregroundColor ?? theme.dialogBackgroundColor.onColor;

    final textFieldBorder = theme.inputDecorationTheme.defaultBorder;

    final headerBorderRadius = borderRadius ??
        theme.dialogTheme.shape?.borderRadius?.at(context).copyWith(
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            );

    return Material(
      type: backgroundColor != null
          ? MaterialType.canvas
          : MaterialType.transparency,
      color: backgroundColor,
      borderRadius: headerBorderRadius,
      clipBehavior: Clip.antiAlias,
      child: Container(
        constraints:
            const BoxConstraints(minHeight: kMinInteractiveDimension + 0.5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: theme.dividerColor,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      bottom: 12.0,
                      left: 20,
                    ),
                    child: Text(
                      title,
                      maxLines: 5,
                      style: TextStyle(
                        color: titleForegroundColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (onTapClose != null)
                  IconButton(
                    onPressed: onTapClose,
                    icon: const Icon(Icons.close_rounded),
                    color: titleForegroundColor,
                  ),
              ],
            ),
            if (searchable)
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 12,
                ),
                child: TextField(
                  cursorColor: titleForegroundColor,
                  onChanged: onSearchTextChanged,
                  style: TextStyle(
                    color: titleForegroundColor,
                  ),
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(maxHeight: 42),
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: titleForegroundColor,
                    ),
                    hintText:
                        "${MaterialLocalizations.of(context).searchFieldLabel}...",
                    hintStyle: TextStyle(
                      color: titleForegroundColor.withOpacity(0.7),
                    ),
                    border: textFieldBorder,
                    enabledBorder: textFieldBorder,
                    focusedBorder: textFieldBorder,
                    fillColor: titleForegroundColor.withOpacity(0.06),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
