import 'package:flutter/material.dart';

/// This class represents the form button styles.
class FormButtonStyle {
  /// Button style
  final ButtonStyle? buttonStyle;

  /// Button height
  final double? height;

  /// Button Width
  final double? width;

  /// If the width could be variable
  final bool widthVariable;

  /// Max lines for text
  final int? maxLines;

  /// The icon label
  final Widget? iconLabel;

  /// If the text has to be uppercase
  final bool toUppercase;

  /// Item label textStyle
  final TextStyle? labelStyle;

  /// Determines if the item is enabled or not
  final bool enabled;

  FormButtonStyle(
      {this.toUppercase = true,
      this.buttonStyle,
      this.height = 20,
      this.labelStyle,
      this.widthVariable = false,
      this.width,
      this.maxLines,
      this.iconLabel,
      this.enabled = true});
}
