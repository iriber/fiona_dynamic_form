import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';
import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/model/validators/form_validator.dart';

class FormIntRangeValidator extends FormValidator {
  int? max;
  int? min;

  FormIntRangeValidator(
      {this.min, this.max, super.defaultErrorMessage = "Invalid number"});

  @override
  bool doValidate(FormItem item) {
    FormIntItem intItem = item as FormIntItem;
    if (intItem.getValue() != null) {
      int number = intItem.getValue() ?? 0;
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
