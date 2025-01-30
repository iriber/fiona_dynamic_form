import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';
import 'package:flutter/services.dart';

/// This class represents a Currency form item.
class FormCurrencyItem extends FormTextItem {
  ///currency symbol
  final String symbol;

  ///determines if the symbol is a prefix or suffix
  final bool isPrefix;

  FormCurrencyItem(
      {required this.symbol,
      this.isPrefix = true,
      super.formItemStyle,
      required super.label,
      super.validators,
      super.value}) {
    inputType = const TextInputType.numberWithOptions(decimal: true);

    super.inputFormatters = [
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
    ];

    if (super.formItemStyle == null) {
      super.formItemStyle = FormItemStyle();
    }
    super.formItemStyle?.inputTextAlign = TextAlign.right;

    if (isPrefix) {
      super.formItemStyle?.prefixText = symbol;
    } else {
      super.formItemStyle?.suffixText = symbol;
    }
  }

  /// Parses the current value to a double
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
