import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';
import 'package:flutter/material.dart';

/// This class represents a text form item widget.
class FormCalendarItemWidget extends FormItemWidget {
  /// Form item
  final FormCalendarItem formItem;

  FormCalendarItemWidget({super.key, required this.formItem});

  @override
  State<FormCalendarItemWidget> createState() => _FormCalendarState();
}

/// This class represents the state of the widget.
class _FormCalendarState extends State<FormCalendarItemWidget> {
  String? error;
  late FormCalendarItem formItem;

  @override
  void initState() {
    super.initState();
    formItem = widget.formItem;

    formItem.addOnChangeListener((value) {
      setState(() {
        error = "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    formItem.onError = ((messages) {
      setState(() {
        String msg = "";
        for (var element in messages) {
          msg += " $element";
        }

        error = msg;
      });
    });

    Widget body;
    switch (formItem.formItemStyle?.labelPosition) {
      case FieldLabelPosition.inside:
        body = buildInput(context);
      case FieldLabelPosition.left:
        body = buildLabelLeft(context);
      case FieldLabelPosition.top:
        body = buildLabelTop(context);
      case FieldLabelPosition.borderTop:
        body = buildLabelBorderTop(context);
      case null:
        body = buildInput(context);
    }
    return body;
  }

  Widget buildLabelTop(BuildContext context) {
    bool hasError = (error ?? "").isNotEmpty;
    TextStyle? style = formItem.formItemStyle?.labelStyle;
    if (hasError) {
      style = formItem.formItemStyle?.errorLabelStyle;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formItem.label,
          style: style,
          textAlign: formItem.formItemStyle?.labelAlign,
        ),
        const SizedBox(
          height: 8,
        ),
        buildInput(context)
      ],
    );
  }

  Widget buildLabelBorderTop(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildInput(context, hideLabel: false)],
    );
  }

  Widget buildLabelLeft(BuildContext context) {
    bool hasError = (error ?? "").isNotEmpty;
    TextStyle? style = formItem.formItemStyle?.labelStyle;
    if (hasError) {
      style = formItem.formItemStyle?.errorLabelStyle;
    }

    int labelSize = formItem.formItemStyle?.labelSize ?? 1;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: labelSize,
          child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                formItem.label,
                style: style,
                textAlign: formItem.formItemStyle?.labelAlign,
              )),
        ),
        Expanded(
            flex: (10 - labelSize), child: buildInput(context, hideLabel: true))
      ],
    );
  }

  Widget buildInput(BuildContext context, {bool hideLabel = false}) {
    return Container(
        // margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 60),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: formItem.formItemStyle?.borderColor ?? Colors.black54,
              width: 1),
        ),
        child: CalendarDatePicker2(
          config: formItem.calendarConfig ??
              CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.single,
                  calendarViewMode: CalendarDatePicker2Mode.day,
                  dayTextStyle: formItem.formItemStyle?.inputStyle,
                  controlsTextStyle: formItem.formItemStyle?.inputStyle,
                  selectedDayTextStyle: formItem.formItemStyle?.inputStyle,
                  selectedDayHighlightColor: Colors.green),
          value: formItem.value ?? [],
          onValueChanged: (List<DateTime?> dates) {
            setState(() {
              formItem.setValue(dates);
              error = "";
            });
          },
        ));
  }
}
