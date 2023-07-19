import 'package:flutter/material.dart';
import 'package:ln_core/ln_core.dart';
import 'package:ln_dialogs/ln_dialogs.dart';

class SelectionDialog<ItemType> extends StatefulWidget {
  final String title;
  final Iterable<ItemType> items;
  final String Function(ItemType) itemLabelBuilder;
  final Function(ItemType) onSubmit;
  final Function()? onCancel;
  final ItemType? selectedItem;
  final bool searchable;
  final EdgeInsets padding;
  final Color? headerBackgroundColor;
  final bool? shrinkWrap;
  final AlignmentGeometry? alignment;
  final ThemeData? theme;
  final double maxWidth;

  const SelectionDialog({
    super.key,
    required this.title,
    required this.items,
    required this.itemLabelBuilder,
    required this.onSubmit,
    this.onCancel,
    this.selectedItem,
    this.searchable = false,
    this.padding = const EdgeInsets.all(24),
    this.headerBackgroundColor,
    this.shrinkWrap,
    this.alignment,
    this.theme,
    this.maxWidth = maxDialogWidth,
  });

  @override
  State<SelectionDialog<ItemType>> createState() =>
      _SelectionDialogState<ItemType>();

  static Future<ItemType?> show<ItemType>({
    required BuildContext context,
    required String title,
    required Iterable<ItemType> items,
    required String Function(ItemType) itemLabelBuilder,
    Function(ItemType)? onSubmit,
    bool showCancelButtons = true,
    ItemType? selectedItem,
    bool searchable = false,
    AlignmentGeometry? alignment,
    bool? shrinkWrap,
    ThemeData? theme,
  }) {
    return showDialog<ItemType>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) => SelectionDialog<ItemType>(
        title: title,
        items: items,
        itemLabelBuilder: itemLabelBuilder,
        onSubmit: (val) {
          Navigator.of(context).pop<ItemType?>(val);
          onSubmit?.call(val);
        },
        onCancel: showCancelButtons
            ? () => Navigator.of(context).pop<ItemType?>(null)
            : null,
        selectedItem: selectedItem,
        searchable: searchable,
        alignment: alignment,
        theme: theme,
        shrinkWrap: shrinkWrap,
      ),
    );
  }
}

class _SelectionDialogState<ItemType> extends State<SelectionDialog<ItemType>> {
  ItemType? _value;
  String _searchText = "";

  @override
  void initState() {
    super.initState();

    _value = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredItems = widget.items.where(
        (e) => widget.itemLabelBuilder(e).toLowerCase().contains(_searchText));
    final onCancel = widget.onCancel;

    final dialog = AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: widget.padding,
      buttonPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      title: DialogHeader(
        searchable: widget.searchable,
        title: widget.title,
        onSearchTextChanged: (val) => setState(() {
          _searchText = val.toLowerCase();
        }),
        onTapClose: onCancel,
        backgroundColor: widget.headerBackgroundColor,
      ),
      actions: <Widget>[
        if (onCancel != null)
          TextButton(
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            onPressed: () {
              onCancel();
            },
          ),
        if (onCancel != null) const SizedBox(width: 6),
        TextButton(
          onPressed: _value == null
              ? null
              : () {
                  widget.onSubmit(_value as ItemType);
                },
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
        ),
      ],
      content: Container(
        width: widget.maxWidth,
        constraints: const BoxConstraints(minHeight: 200),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: filteredItems.isNotEmpty
            ? ListView.builder(
                shrinkWrap: widget.shrinkWrap ?? !widget.searchable,
                itemCount: filteredItems.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => RadioListTile<ItemType>(
                  title: HighlightedText(
                    widget.itemLabelBuilder(filteredItems.elementAt(index)),
                    highlightedText: _searchText,
                  ),
                  value: filteredItems.elementAt(index),
                  groupValue: _value,
                  selected: _value == filteredItems.elementAt(index),
                  onChanged: (val) => setState(() {
                    _value = val;
                  }),
                ),
              )
            : Center(
                child: Icon(Icons.web_asset_off_rounded),
              ),
      ),
    );

    return widget.theme != null
        ? Theme(
            data: widget.theme as ThemeData,
            child: dialog,
          )
        : dialog;
  }
}
