import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';
import 'package:flutter/material.dart';

/// This class represents a text form item widget.
class FormDatetimeItemWidget extends FormItemWidget {
  /// Form item
  final FormDatetimeItem formItem;

  /// Controller.
  final TextEditingController controller = TextEditingController();

  FormDatetimeItemWidget({super.key, required this.formItem});

  @override
  State<FormDatetimeItemWidget> createState() => _FormDatetimeItemWidgetState();
}

/// This class represents the state of the widget.
class _FormDatetimeItemWidgetState extends State<FormDatetimeItemWidget> {
  String? error;
  late FormDatetimeItem formItem;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: formItem.value ?? DateTime.now(), // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != formItem.value) {
      setState(() {
        formItem.value = picked;
      });
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: formItem.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: formItem.value != null
            ? TimeOfDay.fromDateTime(formItem.value!)
            : TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          formItem.value = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    formItem = widget.formItem;
    widget.controller.text = formItem.initialValue ?? formItem.value ?? "";

    widget.controller.addListener(() {
      formItem.value = (widget.controller.text);
      setState(() {
        error = "";
      });
    });

    formItem.addOnChangeListener((value) {
      widget.controller.text = value ?? "";
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
    bool hasError = (error ?? "").isNotEmpty;
    return GestureDetector(
      onTap: () =>
          (formItem.withTime) ? _selectDateTime(context) : _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              prefixIcon: formItem.formItemStyle?.prefixIcon,
              filled: true,
              fillColor: formItem.formItemStyle?.fillColor ?? Colors.white30,
              contentPadding: const EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: formItem.formItemStyle?.focusedBorderColor ??
                        Colors.black87,
                    width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        formItem.formItemStyle?.borderColor ?? Colors.black54,
                    width: 1.0),
              ),
              labelStyle: formItem.formItemStyle?.labelStyle,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: const OutlineInputBorder(),
              prefix: const VerticalDivider(
                width: 10,
              ),
              labelText: (hideLabel) ? null : "  ${formItem.label}",
              errorBorder: hasError
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: formItem.formItemStyle?.errorBorderColor ??
                              Colors.red,
                          width: 1.0),
                    )
                  : null,
              errorText: hasError ? error : null,
              errorStyle: formItem.formItemStyle?.errorInputStyle),
          controller: TextEditingController(
            text: formItem.formatValue(),
          ),
        ),
      ),
    );
  }
}
