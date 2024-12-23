import 'package:fiona_dynamic_form/src/model/form_bool_item.dart';
import 'package:fiona_dynamic_form/src/model/form_text_item.dart';
import 'package:fiona_dynamic_form/src/model/form_select_item.dart';
import 'package:fiona_dynamic_form/src/model/validators/form_max_length_validator.dart';
import 'package:fiona_dynamic_form/src/model/validators/form_required_validator.dart';
import 'package:fiona_dynamic_form/src/model/dynamic_form.dart';
import 'package:example/example/controllers/city_controller.dart';
import 'package:example/example/controllers/country_controller.dart';
import 'package:example/example/controllers/province_controller.dart';

import 'model/employee.dart';



class FormEmployee  extends DynamicForm{

  FormEmployee(){

    FormTextItem name = FormTextItem(label: "Name", validators: [FormMaxLengthValidator(15),FormRequiredValidator()]);

    FormTextItem password = FormTextItem(label: "Password");

    FormSelectItem country = FormSelectItem(label: "Country", validators: [FormRequiredValidator()], selectFieldController: CountryController());

    FormSelectItem state = FormSelectItem(label: "State", validators: [FormRequiredValidator()], selectFieldController: ProvinceController());

    FormSelectItem city = FormSelectItem(label: "City", validators: [FormRequiredValidator()], selectFieldController:  CityController());

    state.addOnChangeListener ((newStateSelected){
      city.changeFilter(newStateSelected);
    });
    country.addOnChangeListener ((newCountrySelected){
      state.changeFilter(newCountrySelected);
    });

    FormBoolItem rememberMe = FormBoolItem(label: "Remember Me");

    addField("name", name);
    addField("password", password);
    addField("country", country);
    addField("province", state);
    addField("city", city);
    addField("rememberMe", rememberMe);

  }

  Employee getEmployee(){

    Map<String, dynamic> empMap = buildObject();
    Employee employee = Employee(name: empMap["name"], password: empMap["password"]);
    employee.rememberMe = empMap["rememberMe"];
    employee.city = empMap["city"];
    employee.province = empMap["province"];
    employee.country = empMap["country"];
    return employee;
  }

  void setEmployee(Employee employee){

    setItemValue("name", employee.name);
    setItemValue("password", employee.password);
    setItemValue("country", employee.country);
    setItemValue("province", employee.province);
    setItemValue("city", employee.city);
    setItemValue("rememberMe", employee.rememberMe);

  }

}




