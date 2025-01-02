import 'package:fiona_dynamic_form/src/model/form_select_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_item_widget.dart';
import 'package:flutter/material.dart';

/// This class represents a text form item widget.
class FormSelectItemWidget extends FormItemWidget {
  final FormSelectItem formItem;

  const FormSelectItemWidget({super.key, required this.formItem});

  @override
  State<FormSelectItemWidget> createState() => _FormSelectItemWidgetState();
}

/// This class represents the state of the widget.
class _FormSelectItemWidgetState extends State<FormSelectItemWidget> {
  String? error;
  List items = List.empty(growable: true);
  dynamic selectedValue;
  TextEditingController controller = TextEditingController();
  late FormSelectItem formItem;

  @override
  void initState() {
    super.initState();

    formItem = widget.formItem;
    selectedValue = formItem.value;
    formItem.selectFieldController.selected = selectedValue;
    if (formItem.fillAllItems && items.isEmpty) {
      formItem.selectFieldController.findAll().then((results) {
        setState(() {
          items = results;
        });
      });
    }

    formItem.addOnChangeListener((value) {
      formItem.selectFieldController.selected = value;
      formItem.value;
      setState(() {
        error = "";
      });
    });

    formItem.onFilterChange = ((value) {
      formItem.selectFieldController.findAll().then((results) {
        setState(() {
          error = "";
          items = results;
        });
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

    if (formItem.enableSearch) {
      return buildSearchEnabled(context);
    } else {
      return buildSearchDisabled(context);
    }
  }

  Widget buildSearchDisabled(BuildContext context) {
    bool hasError = (error ?? "").isNotEmpty;

    return InputDecorator(
        decoration: InputDecoration(
            prefixText: "    ",
            prefixIcon: formItem.formItemStyle?.prefixIcon,
            //errorText: error,
            filled: true,
            fillColor: formItem.formItemStyle?.fillColor ?? Colors.white30,
            contentPadding: const EdgeInsets.only(right: 0),
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
        isEmpty: selectedValue == null,
        child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
          style: formItem.formItemStyle?.inputStyle,

          //icon: widget.prefixIcon??widget.prefixIcon,
          value: formItem.selectFieldController.selected,
          hint: Text("  ${formItem.label}"),
          items: items.map((dynamic option) {
            return DropdownMenuItem<dynamic>(
              value: option,
              child: Text(formItem.selectFieldController.getItemLabel(option)),
            );
          }).toList(),
          onChanged: (dynamic newValue) {
            if (newValue == null) {
              formItem.selectFieldController.setTextNotFound(controller.text);
            } else {
              formItem.selectFieldController.setSelected(newValue);
            }
            setState(() {
              selectedValue = newValue;
              formItem.setValue(selectedValue);
              error = "";
            });
          },
          isExpanded: true, // Para que ocupe todo el ancho
        )));
  }

  Widget buildSearchEnabled(BuildContext context) {
    if (items.isEmpty && formItem.selectFieldController.selected != null) {
      items.add(formItem.selectFieldController.selected);
    }
    return DropdownMenu(
      width: double.infinity,
      //initialSelection: ColorLabel.green,
      controller: formItem.enableSearch ? controller : null,
      // requestFocusOnTap is enabled/disabled by platforms when it is null.
      // On mobile platforms, this is false by default. Setting this to true will
      // trigger focus request on the text field and virtual keyboard will appear
      // afterward. On desktop platforms however, this defaults to true.
      requestFocusOnTap: true,
      label: Text(formItem.label),
      initialSelection: formItem.selectFieldController.selected,
      onSelected: (dynamic selected) {
        if (selected == null) {
          formItem.selectFieldController.setTextNotFound(controller.text);
        } else {
          formItem.selectFieldController.setSelected(selected);
        }
      },
      dropdownMenuEntries: items.map<DropdownMenuEntry>((item) {
        return DropdownMenuEntry(
          value: item,
          label: formItem.selectFieldController.getItemLabel(item),
          enabled: true,
        );
      }).toList(),
    );
  }
}
