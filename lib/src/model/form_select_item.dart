import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_select_item_widget.dart';
import 'package:flutter/cupertino.dart';

class FormSelectItem extends FormItem{

  FormSelectFieldController selectFieldController;
  final bool enableSearch;
  final bool fillAllItems;
  Function(dynamic)? onFilterChange;


  FormSelectItem(
      {required this.selectFieldController, this.enableSearch=false, this.fillAllItems=true, super.initialValue, super.formItemStyle,required super.label, super.validators});

  changeFilter(dynamic value){
    selectFieldController.filter = value;
    selectFieldController.selected = null;
    setValue(null);
    if( onFilterChange != null){
      onFilterChange!(value);
    }
  }

  @override
  bool isEmpty(){
    return selectFieldController.isEmpty(value);
  }

  @override
  Widget draw(BuildContext context) {
    return  FormSelectItemWidget(formItem:this);
  }

}


abstract class FormSelectFieldController{

  String? textNotFound;
  dynamic selected;
  dynamic filter;

  changeFilter(dynamic filter){
    this.filter = filter;
  }

  Future<List> findItems(String text);

  String getItemLabel(item);
  int getItemId(item);

  bool isEmpty(item){
    return ( item == null ) || getItemId(item) <= 0;
  }

  Future<List> findAll() async{
    return findItems("");
  }

  void setTextNotFound(String text) {
    textNotFound = text;
    setSelected(null);
  }

  void setSelected( item ){
    selected = item;
  }

  dynamic getSelected(){
    return selected;
  }
}
