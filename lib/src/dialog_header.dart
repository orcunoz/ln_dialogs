import 'package:flutter/material.dart';
import 'package:ln_core/ln_core.dart';

class DialogHeader extends StatelessWidget implements PreferredSizeWidget {
  const DialogHeader({
    super.key,
    required this.title,
    this.searchable = false,
    this.onSearchTextChanged,
    this.onTapClose,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.elevation = .0,
  });

  final String title;
  final bool searchable;
  final Function(String)? onSearchTextChanged;
  final Function()? onTapClose;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double elevation;

  static BorderRadius? borderRadiusOf(BuildContext context,
      {ThemeData? theme}) {
    theme ??= Theme.of(context);
    return (DialogTheme.of(context).shape?.borderRadius ??
            theme.dialogTheme.shape?.borderRadius)
        ?.at(context)
        .copyWith(
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foregroundColor =
        this.foregroundColor ?? theme.dialogBackgroundColor.onColor;

    final textFieldBorder = theme.inputDecorationTheme.defaultBorder;

    return SizedBox(
      height: preferredSize.height,
      child: Material(
        color: backgroundColor ?? theme.dialogBackgroundColor,
        type: MaterialType.transparency,
        clipBehavior: Clip.antiAlias,
        elevation: elevation,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (onTapClose != null)
                  InkWell(
                    borderRadius: BorderRadius.circular(kToolbarHeight / 2),
                    child: SizedBox.square(
                      dimension: kToolbarHeight,
                      child: Icon(Icons.arrow_back_rounded),
                    ),
                    onTap: onTapClose,
                  )
                else
                  SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: foregroundColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
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
                  cursorColor: foregroundColor,
                  onChanged: onSearchTextChanged,
                  style: TextStyle(
                    color: foregroundColor,
                  ),
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(maxHeight: 42),
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: foregroundColor,
                    ),
                    hintText:
                        "${MaterialLocalizations.of(context).searchFieldLabel}...",
                    hintStyle: TextStyle(
                      color: foregroundColor.withOpacity(0.7),
                    ),
                    border: textFieldBorder,
                    enabledBorder: textFieldBorder,
                    focusedBorder: textFieldBorder,
                    fillColor: foregroundColor.withOpacity(0.06),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      height ?? (kToolbarHeight + (searchable ? kMinInteractiveDimension : 0)));
}
