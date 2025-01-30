import 'dart:math';

import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_datetime_item_widget.dart';
import 'package:flutter/cupertino.dart';

/// This class represents a Date time form item.
class FormDatetimeItem extends FormItem {
  final String dateFormat;
  final String timeFormat;
  final bool withTime;
  final bool onlyTime;

  FormDatetimeItem(
      {super.formItemStyle,
      required super.label,
      this.withTime = false,
      this.onlyTime = false,
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
    return FormDatetimeItemWidget(
        key: ValueKey(Random().nextInt(10000)), formItem: this);
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
    if (onlyTime) {
      return formatDateTime(value, timeFormat);
    } else if (withTime) {
      return formatDateTime(value, "$dateFormat $timeFormat");
    } else {
      return formatDateTime(value, dateFormat);
    }
  }

  String formatDateTime(DateTime dateTime, String format) {
    return format
        .replaceAll('yyyy', dateTime.year.toString())
        .replaceAll('MM', dateTime.month.toString().padLeft(2, '0'))
        .replaceAll('dd', dateTime.day.toString().padLeft(2, '0'))
        .replaceAll('HH', dateTime.hour.toString().padLeft(2, '0'))
        .replaceAll('mm', dateTime.minute.toString().padLeft(2, '0'))
        .replaceAll('ss', dateTime.second.toString().padLeft(2, '0'));
  }
}
