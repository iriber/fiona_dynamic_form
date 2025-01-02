import 'package:fiona_dynamic_form/src/model/form_bool_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_item_widget.dart';
import 'package:flutter/material.dart';

/// This class represents a boolean form item widget (checkbox).
class FormBoolItemWidget extends FormItemWidget {
  final FormBoolItem formItem;

  const FormBoolItemWidget({super.key, required this.formItem});

  @override
  State<FormBoolItemWidget> createState() => _FormBoolItemWidgetState();
}

/// This class represents the state of the widget.
class _FormBoolItemWidgetState extends State<FormBoolItemWidget> {
  String? error;
  late FormBoolItem formItem;
  bool value = false;

  @override
  void initState() {
    super.initState();
    formItem = widget.formItem;
    value = formItem.initialValue ?? false;
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
    formItem.addOnChangeListener((value) {
      setState(() {
        error = "";
      });
    });

    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            onChanged: (bool? newValue) {
              setState(() {
                value = newValue ?? false;
                formItem.setValue(value);
              });
            },
          ), //activeColor: Colors.lightGreenAccent),
          Text(formItem.label, style: formItem.formItemStyle?.labelStyle),
        ],
      ),
    );
  }
}
