
import 'package:fiona_dynamic_form/src/model/form_item.dart';

abstract class FormValidator {

  String Function(FormItem item)? onValidateError;
  String? defaultErrorMessage;
  String? result;

  FormValidator({this.onValidateError, this.defaultErrorMessage});

  bool validate(FormItem item){
    bool isValid = true;
    if(!doValidate(item)){
      isValid = false;
      if(onValidateError!=null){
        result = onValidateError!(item);
      }else{
        result = defaultErrorMessage??"";
      }
    }else{
      result = "";
    }
    return isValid;
  }

  bool doValidate(FormItem item);

}