import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_bool_item_widget.dart';
import 'package:flutter/cupertino.dart';

class FormBoolItem extends FormItem{

  FormBoolItem(
      {
        super.formItemStyle,required super.label, super.validators, super.initialValue});


  @override
  bool isEmpty(){
    return false;
  }

  @override
  Widget draw(BuildContext context) {
    return  FormBoolItemWidget(formItem:this);
  }

  @override
  bool getValue(){
    if( value == null ){
      return false;
    }else{
      return value as bool;
    }
  }
}
