import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_datetime_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

/// This class represents a Date time form item.
class FormDatetimeItem extends FormItem {
  final String dateFormat;
  final String timeFormat;
  final bool withTime;

  FormDatetimeItem(
      {super.formItemStyle,
      required super.label,
      this.withTime = false,
      this.dateFormat = "MM/dd/yyyy",
      this.timeFormat = "HH:mm",
      super.validators,
      super.value});

  @override
  bool isEmpty() {
    return value == null || (value?.isEmpty ?? true);
  }

  @override
  Widget draw(BuildContext context) {
    return FormDatetimeItemWidget(formItem: this);
  }

  @override
  DateTime? getValue() {
    if (value == null) {
      return null;
    } else {
      DateTime? date = value as DateTime?;
      return date;
    }
  }

  String formatValue() {
    if (value == null) {
      return "";
    }

    if (withTime) {
      return DateFormat("$dateFormat $timeFormat").format(value);
    } else {
      return DateFormat(dateFormat).format(value);
    }
  }
}
