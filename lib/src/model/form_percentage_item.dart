import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';
import 'package:flutter/services.dart';

/// This class represents a Percentage form item.
class FormPercentageItem extends FormTextItem {
  ///determines the digits of fraction part
  final int digits;

  ///determines if the symbol is a prefix or suffix
  final bool isPrefix;

  FormPercentageItem(
      {this.digits = 2,
      this.isPrefix = false,
      super.formItemStyle,
      required super.label,
      super.validators,
      super.value}) {
    inputType = const TextInputType.numberWithOptions(decimal: true);

    if (digits > 0) {
      super.inputFormatters = [
        FilteringTextInputFormatter.allow(
            RegExp(r'^\d*\.?\d{0,' + digits.toString() + '}'))
      ];
    } else {
      super.inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    }

    if (super.formItemStyle == null) {
      super.formItemStyle = FormItemStyle();
    }
    super.formItemStyle?.inputTextAlign = TextAlign.right;

    if (isPrefix) {
      super.formItemStyle?.prefixText = "%";
    } else {
      super.formItemStyle?.suffixText = "%";
    }
  }

  /// Parses the current value to a double
  @override
  dynamic getValue() {
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
