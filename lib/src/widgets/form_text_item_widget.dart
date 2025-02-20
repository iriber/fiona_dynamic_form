import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';
import 'package:flutter/material.dart';

/// This class represents a text form item widget.
class FormTextItemWidget extends FormItemWidget {
  /// Form item
  final FormTextItem formTextItem;

  /// Controller.
  final TextEditingController controller = TextEditingController();

  FormTextItemWidget({super.key, required this.formTextItem});

  @override
  State<FormTextItemWidget> createState() => _FormTextFieldState();
}

/// This class represents the state of the widget.
class _FormTextFieldState extends State<FormTextItemWidget> {
  String? error;
  late FormTextItem formItem;

  @override
  void initState() {
    super.initState();
    formItem = widget.formTextItem;
    widget.controller.text =
        formItem.initialValue?.toString() ?? formItem.value?.toString() ?? "";

    widget.controller.addListener(() {
      if (!formItem.isEqual(widget.controller.text)) {
        formItem.setValue(widget.controller.text);
        if (mounted) {
          setState(() {
            error = "";
          });
        };

      }
    });

    formItem.addOnChangeListener((value) {
      String originalStr = widget.controller.text;
      if (!formItem.areEquals(originalStr, value)) {
        widget.controller.text = value?.toString() ?? "";
        if (mounted) {
          setState(() {
            error = "";
          });
        };
      }
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

/*
    formItem.onInitializeValue = ((dynamic value) {
      widget.controller.text = (value!=null )? value: "";
    });
*/
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

    return TextFormField(
      textDirection: TextDirection.rtl,
      textAlign: formItem.formItemStyle?.inputTextAlign ?? TextAlign.start,
      style: formItem.formItemStyle?.inputStyle,
      obscureText: formItem.formItemStyle?.hideText ?? false,
      keyboardType: formItem.inputType,
      inputFormatters: formItem.inputFormatters,
      enabled: formItem.formItemStyle?.enabled,
      controller: widget.controller,
      initialValue: formItem.initialValue,
      decoration: InputDecoration(
          prefixIcon: formItem.formItemStyle?.prefixIcon,
          prefixText: formItem.formItemStyle?.prefixText,
          prefixStyle: formItem.formItemStyle?.inputStyle,
          suffixText: formItem.formItemStyle?.suffixText,
          suffixStyle: formItem.formItemStyle?.inputStyle,
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
                color: formItem.formItemStyle?.borderColor ?? Colors.black54,
                width: 1.0),
          ),
          labelStyle: formItem.formItemStyle?.labelStyle,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: const OutlineInputBorder(),
          //prefix: const VerticalDivider(            width: 10,          ),
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
    );
  }
}
