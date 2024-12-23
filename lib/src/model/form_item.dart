import 'package:fiona_dynamic_form/src/model/form_item_style.dart';
import 'package:fiona_dynamic_form/src/model/validators/form_validator.dart';
import 'package:flutter/cupertino.dart';

abstract class FormItem{

  List<FormValidator>? validators;
  final String label;
  final FormItemStyle? formItemStyle;
  final dynamic initialValue;
  dynamic value;

  List<Function(dynamic)> onChangeListeners = List.empty(growable: true);

  Function(List<String> msg)? onError;

  FormItem({
    required this.label,
    this.initialValue,
    this.formItemStyle, this.onError, this.validators});

  addOnChangeListener(Function(dynamic) onChange){
    onChangeListeners.add( onChange );
  }

  dynamic getValue(){
    return value;
  }
  setValue(dynamic value){
    this.value = value;
    for (var onChange in onChangeListeners) {
      onChange(value);
    }
  }

  bool isEmpty();

  bool validate({String msg="Required"}){
    bool isValid=true;
    validators?.forEach((element) {
      isValid = element.validate(this) && isValid;
    });
    if(!isValid && onError!=null){
      onError!(getErrorMessages());
    }
    return isValid;
  }

  List<String> getErrorMessages(){
    List<String> messages = List<String>.empty(growable: true);
    validators?.forEach((element) {
      if(element.result!=null && (element.result?.isNotEmpty??false)){
        messages.add(element.result??"");
      }
    });
    return messages;
  }


  Widget draw(BuildContext context);

}
