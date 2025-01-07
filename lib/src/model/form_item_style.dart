import 'package:fiona_dynamic_form/src/widgets/form_item_widget.dart';
import 'package:flutter/cupertino.dart';

/// This class represents the item styles.
class FormItemStyle {
  /// Item label textStyle
  final TextStyle? labelStyle;

  /// Item label position
  final FieldLabelPosition labelPosition;

  /// Icon prefix
  Widget? prefixIcon;

  /// Text prefix
  String? prefixText;

  /// Text suffix
  String? suffixText;

  /// Label size (between 1 and 10)
  final int labelSize;

  /// Label textAlign
  final TextAlign? labelAlign;

  /// To hide the text (for password)
  final bool hideText;

  /// Error message
  final String? error;

  /// Error message textStyle
  final TextStyle? errorLabelStyle;

  /// Error message border color
  final Color? errorBorderColor;

  /// Error message input style
  final TextStyle? errorInputStyle;

  /// Determines if the item is enabled or not
  final bool enabled;

  /// Input TextAlign
  TextAlign? inputTextAlign;

  /// Input style
  final TextStyle? inputStyle;

  /// Border color when the input is focused
  final Color? focusedBorderColor;

  /// Input Fill color
  final Color? fillColor;

  /// Input Border color
  final Color? borderColor;

  FormItemStyle(
      {this.fillColor,
      this.borderColor,
      this.errorBorderColor,
      this.errorInputStyle,
      this.focusedBorderColor,
      this.labelAlign,
      this.labelSize = 4,
      this.labelStyle,
      this.inputStyle,
      this.labelPosition = FieldLabelPosition.borderTop,
      this.inputTextAlign,
      this.errorLabelStyle,
      this.hideText = false,
      this.prefixIcon,
      this.prefixText,
      this.suffixText,
      this.error,
      this.enabled = true});
}
