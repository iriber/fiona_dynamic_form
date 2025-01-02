import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_calendar_item_widget.dart';
import 'package:flutter/cupertino.dart';

/// This class represents a Date time form item.
class FormCalendarItem extends FormItem {
  final CalendarDatePicker2Config? calendarConfig;

  FormCalendarItem(
      {this.calendarConfig,
      super.formItemStyle,
      required super.label,
      super.validators,
      super.value});

  @override
  bool isEmpty() {
    return value == null || (value?.isEmpty ?? true);
  }

  @override
  Widget draw(BuildContext context) {
    return FormCalendarItemWidget(formItem: this);
  }

  DateTime? getValueFrom() {
    if (value == null) {
      return null;
    } else {
      List<DateTime?> dates = value as List<DateTime?>;
      if (dates.isNotEmpty) {
        return dates.first;
      } else {
        return null;
      }
    }
  }

  DateTime? getValueTo() {
    if (value == null) {
      return null;
    } else {
      List<DateTime?> dates = value as List<DateTime?>;
      if (dates.isNotEmpty) {
        return dates.last;
      } else {
        return null;
      }
    }
  }
}
