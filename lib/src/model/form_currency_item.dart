import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';
import 'package:flutter/services.dart';

/// This class represents an Integer form item.
class FormCurrencyItem extends FormTextItem {
  ///money symbol
  final String moneySymbol;

  ///determines if the symbol is a prefix (or postfix)
  final bool isPrefix;

  FormCurrencyItem(
      {required this.moneySymbol,
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
      super.formItemStyle?.prefixText = moneySymbol;
      super.formItemStyle?.prefixIcon = null;
    } else {
      super.formItemStyle?.suffixText = moneySymbol;
    }
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
