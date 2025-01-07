import 'package:fiona_dynamic_form/src/model/form_text_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// This class represents an Integer form item.
class FormIntItem extends FormTextItem {
  FormIntItem(
      {super.formItemStyle,
      required super.label,
      super.validators,
      super.value,
      super.inputType = TextInputType.number}) {
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
