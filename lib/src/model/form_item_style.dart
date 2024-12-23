import 'package:fiona_dynamic_form/src/widgets/form_text_item_widget.dart';
import 'package:flutter/cupertino.dart';

class FormItemStyle{

  final TextStyle? labelStyle;
  final FieldLabelPosition labelPosition;
  final Widget? prefixIcon;
  final int labelSize; /* between 1 and 10 */
  final TextAlign? labelAlign;

  final bool hideText;

  final String? error;
  final TextStyle? errorLabelStyle;
  final Color? errorBorderColor;
  final TextStyle? errorInputStyle;

  final bool enabled;

  final TextAlign? inputTextAlign;
  final TextStyle? inputStyle;

  final Color? focusedBorderColor;
  final Color? fillColor;
  final Color? borderColor;


  FormItemStyle({
    this.fillColor, this.borderColor,
    this.errorBorderColor, this.errorInputStyle,
    this.focusedBorderColor, this.labelAlign, this.labelSize=4,
    this.labelStyle, this.inputStyle, this.labelPosition=FieldLabelPosition.inside,
    this.inputTextAlign,this.errorLabelStyle,
    this.hideText=false, this.prefixIcon, this.error, this.enabled=true});

}
