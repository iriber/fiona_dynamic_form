import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_text_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// This class represents a Text form item.
class FormTextItem extends FormItem {
  /// Input type
  final TextInputType? inputType;
  // Input type formatters
  final List<TextInputFormatter>? inputFormatters;

  FormTextItem(
      {this.inputType,
      this.inputFormatters,
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
    return FormTextItemWidget(formTextItem: this);
  }

  @override
  String? getValue() {
    if (value == null) {
      return null;
    } else {
      return value as String;
    }
  }
}
