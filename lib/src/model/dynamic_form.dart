
import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:flutter/cupertino.dart';

class DynamicForm{

  Map<String, FormItem>? items = {};


  void addField(String key, FormItem item){
    items?.putIfAbsent(key, () => item);
  }

  FormItem? getItem(String key){
   return items?[key];
  }

  dynamic getItemValue(String key){
    return items?[key]?.getValue();
  }
  void setItemValue(String key, dynamic value){
    items?[key]?.setValue(value);
  }

  Map<String,dynamic> buildObject(){
    Map<String,dynamic> result={};

    items?.forEach((key, item) {
      result.putIfAbsent(key, () => getItemValue(key));
    });

    return result;
  }

  bool validate(){
    bool isValid = true;

    items?.forEach((key, item) {
      isValid = item.validate() && isValid  ;
    });

    return isValid;
  }


  Widget draw(BuildContext context) {

    List<Widget> children = List.empty(growable: true);

    items?.forEach((key, item) {
      children.add(Container(
        padding: const EdgeInsets.all(10),
        child: item.draw(context),
      ));
    });

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: children,
          ),
        )
      ],
    );
  }

}
