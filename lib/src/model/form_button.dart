import 'package:fiona_dynamic_form/src/model/form_button_style.dart';
import 'package:fiona_dynamic_form/src/widgets/form_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This class represents a form button.
class FormButton {
  /// The button label
  final String label;

  /// The callback function when tap the button
  final Function(BuildContext context) onTap;

  /// The button style
  final FormButtonStyle? formButtonStyle;

  FormButton({required this.label, required this.onTap, this.formButtonStyle});

  Widget draw(BuildContext context) {
    return FormButtonWidget(formButton: this);
  }
}
