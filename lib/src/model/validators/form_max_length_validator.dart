import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/model/form_text_item.dart';
import 'package:fiona_dynamic_form/src/model/validators/form_validator.dart';

class FormMaxLengthValidator extends FormValidator {
  int maxLength;

  FormMaxLengthValidator(this.maxLength,
      {super.defaultErrorMessage = "Max length exceeded"});

  @override
  bool doValidate(FormItem item) {
    FormTextItem textItem = item as FormTextItem;
    if (textItem.getValue() != null) {
      return (textItem.getValue() as String).length < maxLength;
    } else {
      return true;
    }
  }
}
