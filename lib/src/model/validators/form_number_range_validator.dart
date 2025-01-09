import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';

class FormNumberRangeValidator extends FormValidator {
  double? max;
  double? min;

  FormNumberRangeValidator(
      {this.min, this.max, super.defaultErrorMessage = "Invalid number"});

  @override
  bool doValidate(FormItem item) {
    if (item.getValue() != null) {
      double number = (item.getValue().toDouble()) ?? 0;
      bool isValid = true;
      if (max != null) {
        isValid = number <= (max ?? 0);
      }
      if (isValid && min != null) {
        isValid = number >= (min ?? 0);
      }
      return isValid;
    } else {
      return true;
    }
  }
}
