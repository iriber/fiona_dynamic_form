import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';
import 'package:fiona_dynamic_form/src/model/form_text_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// This class represents an Integer form item.
class FormDecimalItem extends FormTextItem {
  final int digits;

  FormDecimalItem(
      {this.digits = 2,
      super.formItemStyle,
      required super.label,
      super.validators,
      super.value}) {
    inputType = const TextInputType.numberWithOptions(decimal: true);

    if (super.formItemStyle == null) {
      super.formItemStyle = FormItemStyle();
    }
    super.formItemStyle?.inputTextAlign = TextAlign.right;

    //String strRegex = '^\d*\.?\d{0,$digits}';
    super.inputFormatters = [
      FilteringTextInputFormatter.allow(
          RegExp(r'^\d*\.?\d{0,' + digits.toString() + '}'))
    ];
  }

  /// Parses the current value to an integer
  @override
  dynamic getValue() {
    try {
      return double.parse(value);
    } catch (error) {
      return null;
    }
  }
}
