import 'package:fiona_dynamic_form/src/model/form_text_item.dart';
import 'package:flutter/cupertino.dart';

class FormIntItem extends FormTextItem{

  FormIntItem(
      { super.formItemStyle,required super.label, super.validators, super.initialValue, super.inputType=TextInputType.number});


  int? parseInt() {
    try{
      return int.parse(value);
    }catch(error){
      return null;
    }
  }
}
