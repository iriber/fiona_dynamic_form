import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';
import 'package:flutter/services.dart';

/// This class represents a Decimal form item.
class FormDecimalItem extends FormTextItem {
  ///determines the digits of fraction part
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

    super.inputFormatters = [
      FilteringTextInputFormatter.allow(
          RegExp(r'^\d*\.?\d{0,' + digits.toString() + '}'))
    ];
  }

  /// Parses the current value to an integer
  @override
  dynamic parseValue(value) {
    if (value is double) {
      return value;
    }
    try {
      return double.parse(value);
    } catch (error) {
      return null;
    }
  }


}
