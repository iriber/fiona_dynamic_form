import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/model/validators/form_validator.dart';

class FormRequiredValidator extends FormValidator {
  FormRequiredValidator({super.defaultErrorMessage = "Required"});

  @override
  bool doValidate(FormItem item) {
    return !item.isEmpty();
  }
}
