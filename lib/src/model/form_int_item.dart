import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';
import 'package:flutter/services.dart';

/// This class represents an Integer form item.
class FormIntItem extends FormTextItem {
  FormIntItem(
      {super.formItemStyle,
      required super.label,
      super.validators,
      super.value,
      super.inputType = TextInputType.number}) {
    if (super.formItemStyle == null) {
      super.formItemStyle = FormItemStyle();
    }
    super.formItemStyle?.inputTextAlign = TextAlign.right;

    super.inputFormatters = [
      FilteringTextInputFormatter.digitsOnly,
    ];
  }

  /// Parses the current value to an integer
  @override
  dynamic getValue() {
    try {
      return int.parse(value);
    } catch (error) {
      return null;
    }
  }
}
