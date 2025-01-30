import 'dart:math';

import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_select_item_widget.dart';
import 'package:flutter/cupertino.dart';

/// This class represents a select form item (dropdown).
class FormSelectItem extends FormItem {
  /// Controller of the item
  FormSelectFieldController selectFieldController;

  /// To enable search or not (like autocomplete).
  final bool enableSearch;

  /// To fill all items at the begins
  final bool fillAllItems;

  /// A callback function to alert a filter change.
  Function(dynamic)? onFilterChange;

  FormSelectItem(
      {required this.selectFieldController,
      this.enableSearch = false,
      this.fillAllItems = true,
      super.value,
      super.formItemStyle,
      required super.label,
      super.validators});

  /// Changes the current filter (parent)
  changeFilter(dynamic value) {
    selectFieldController.filter = value;
    selectFieldController.selected = null;
    setValue(null);
    if (onFilterChange != null) {
      onFilterChange!(value);
    }
  }

  filter(dynamic value) {
    selectFieldController.filter = value;
  }

  @override
  bool isEmpty() {
    return selectFieldController.isEmpty(value);
  }

  @override
  Widget draw(BuildContext context) {
    return FormSelectItemWidget(key:ValueKey(Random().nextInt(10000)), formItem: this);
  }
}

/// This class represents a controller for a select item.
abstract class FormSelectFieldController {
  String? textNotFound;
  dynamic selected;
  dynamic filter;

  changeFilter(dynamic filter) {
    this.filter = filter;
  }

  Future<List> findItems(String text);

  String getItemLabel(item);
  int getItemId(item);

  bool isEmpty(item) {
    return (item == null) || getItemId(item) <= 0;
  }

  Future<List> findAll() async {
    return findItems("");
  }

  void setTextNotFound(String text) {
    textNotFound = text;
    setSelected(null);
  }

  void setSelected(item) {
    selected = item;
  }

  dynamic getSelected() {
    return selected;
  }
}
