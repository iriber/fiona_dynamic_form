import 'package:fiona_dynamic_form/src/model/form_button.dart';
import 'package:fiona_dynamic_form/src/model/form_item.dart';
import 'package:fiona_dynamic_form/src/widgets/dynamic_form_widget.dart';
import 'package:flutter/cupertino.dart';

/// This class represents a dynamic form.
class FionaDynamicForm {
  /// It contains the form items.
  Map<String, FormItem>? items = {};

  /// The submit button
  FormButton? btnSubmit;

  /// The cancel button
  FormButton? btnCancel;

  FionaDynamicForm({this.btnSubmit, this.btnCancel});

  /// Add an item to the form
  void addField(String key, FormItem item) {
    items?.putIfAbsent(key, () => item);
  }

  /// Get an item by a key
  FormItem? getItem(String key) {
    return items?[key];
  }

  /// Get the value of an item
  dynamic getItemValue(String key) {
    return items?[key]?.getValue();
  }

  /// Set a value to an item
  void setItemValue(String key, dynamic value) {
    items?[key]?.setValue(value);
  }

  /*
  /// Set a value to an item
  void initializeValue(String key, dynamic value) {
    items?[key]?.initializeValue(value);
  }
*/
  /// Build an map with all the item values
  Map<String, dynamic> buildObject() {
    Map<String, dynamic> result = {};

    items?.forEach((key, item) {
      result.putIfAbsent(key, () => getItemValue(key));
    });

    return result;
  }

  /// Validate the form
  bool validate() {
    bool isValid = true;

    items?.forEach((key, item) {
      isValid = item.validate() && isValid;
    });

    return isValid;
  }

  /// Draw the form
  Widget draw(BuildContext context) {
    return DynamicFormWidget(form: this);
  }
}
