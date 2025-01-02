import 'package:fiona_dynamic_form/src/model/form_item_style.dart';
import 'package:fiona_dynamic_form/src/model/validators/form_validator.dart';
import 'package:flutter/cupertino.dart';

/// This class represents a form item.
abstract class FormItem {
  /// Validators to apply to this item.
  List<FormValidator>? validators;

  /// The item label
  final String label;

  /// The item style
  final FormItemStyle? formItemStyle;

  /// The item initial value
  final dynamic initialValue;

  /// The item current value
  dynamic value;

  /// The collection of listeners to listen changes of the item value
  List<Function(dynamic)> onChangeListeners = List.empty(growable: true);

  /// A callback function to send errors.
  Function(List<String> msg)? onError;

  /// A callback function to initialize the value.
  //Function(dynamic value)? onInitializeValue;

  FormItem(
      {required this.label,
      this.initialValue,
      this.value,
      this.formItemStyle,
      this.onError,
      this.validators});

  /// Adds a listener of changes
  addOnChangeListener(Function(dynamic) onChange) {
    onChangeListeners.add(onChange);
  }

  /// Gets current value
  dynamic getValue() {
    return value;
  }

/*
  /// Sets current value
  initializeValue(dynamic value) {
    // sets the value
    this.value = value;
    // alerts listeners
    if( onInitializeValue!=null) {
      onInitializeValue!(value);
    }
  }
*/
  /// Sets current value
  setValue(dynamic value) {
    // sets the value
    this.value = value;
    // alerts listeners
    for (var onChange in onChangeListeners) {
      onChange(value);
    }
  }

  /// Returns if the current value is empty or not.
  bool isEmpty();

  /// Validates the current value
  bool validate({String msg = "Required"}) {
    bool isValid = true;
    validators?.forEach((element) {
      isValid = element.validate(this) && isValid;
    });
    if (!isValid && onError != null) {
      onError!(getErrorMessages());
    }
    return isValid;
  }

  /// Gets the error messages tied to the last validation
  List<String> getErrorMessages() {
    List<String> messages = List<String>.empty(growable: true);
    validators?.forEach((element) {
      if (element.result != null && (element.result?.isNotEmpty ?? false)) {
        messages.add(element.result ?? "");
      }
    });
    return messages;
  }

  /// Draws the item
  Widget draw(BuildContext context);
}
