import 'dart:math';

import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_bool_item_widget.dart';
import 'package:flutter/cupertino.dart';

/// This class represents a Boolean form item.
class FormBoolItem extends FormItem {
  FormBoolItem(
      {super.formItemStyle,
      required super.label,
      super.validators,
      super.value});

  @override
  bool isEmpty() {
    return false;
  }

  @override
  Widget draw(BuildContext context) {
    return FormBoolItemWidget(
        key: ValueKey(Random().nextInt(10000)), formItem: this);
  }

  @override
  bool getValue() {
    if (value == null) {
      return false;
    } else {
      return value as bool;
    }
  }
}
