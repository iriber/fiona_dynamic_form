import 'package:fiona_dynamic_form/fiona_dynamic_form.dart';
import 'package:example/example/controllers/city_controller.dart';
import 'package:example/example/controllers/country_controller.dart';
import 'package:example/example/controllers/province_controller.dart';
import 'package:flutter/material.dart';

import 'model/employee.dart';

class FormEmployee extends FionaDynamicForm {
  final Function(BuildContext context, Employee employee) onSubmit;
  final Function(BuildContext context) onCancel;

  FormEmployee(
      {required this.onSubmit, required this.onCancel, Employee? employee}) {
    FormTextItem name = FormTextItem(
        label: "Name",
        value: employee?.name,
        formItemStyle: getInputStyle(),
        validators: [FormMaxLengthValidator(15), FormRequiredValidator()]);

    FormTextItem email = FormTextItem(
        label: "Email",
        value: employee?.email,
        formItemStyle: getInputStyle(),
        validators: [FormEmailValidator(), FormRequiredValidator()]);

    FormTextItem password = FormTextItem(
        label: "Password",
        formItemStyle: getPasswordInputStyle(),
        validators: [FormRequiredValidator()]);

    FormDatetimeItem birthday = FormDatetimeItem(
        label: "Birthday",
        withTime: false,
        value: employee?.birthday,
        formItemStyle: getInputStyle());

    FormCurrencyItem salary = FormCurrencyItem(
        label: "Salary",
        symbol: "USD",
        isPrefix: true,
        value: employee?.salary,
        formItemStyle: getInputStyle());

    FormDecimalItem number = FormDecimalItem(
        label: "Number",
        digits: 3,
        value: employee?.number,
        formItemStyle: getInputStyle());

    FormPercentageItem percentage = FormPercentageItem(
        label: "Percentage",
        value: employee?.percentage,
        formItemStyle: getInputStyle());

    number.addOnChangeListener((newNumber) {
      percentage.setValue((newNumber ?? 0) * (salary.getValue() ?? 0));
    });
    salary.addOnChangeListener((newSalary) {
      percentage.setValue((number.getValue() ?? 0) * (newSalary ?? 0));
    });

    FormDatetimeItem lastPost = FormDatetimeItem(
        label: "Last Post",
        withTime: true,
        value: employee?.lastPost,
        formItemStyle: getInputStyle());

    FormDatetimeItem startTime = FormDatetimeItem(
        label: "Start Time",
        onlyTime: true,
        value: employee?.startTime,
        formItemStyle: getInputStyle());

    FormIntItem sinceYear = FormIntItem(
        label: "Since Year",
        value: employee?.employeeSinceYear,
        validators: [
          FormNumberRangeValidator(
              min: 1990,
              max: DateTime.now().year.toDouble(),
              defaultErrorMessage:
                  "Invalid range number [1990,${DateTime.now().year}]")
        ],
        formItemStyle: getInputStyle());

    FormSelectItem country = FormSelectItem(
        label: "Country",
        value: employee?.country,
        validators: [FormRequiredValidator()],
        selectFieldController: CountryController());

    FormSelectItem state = FormSelectItem(
        label: "State",
        value: employee?.province,
        validators: [FormRequiredValidator()],
        selectFieldController: ProvinceController());

    FormSelectItem city = FormSelectItem(
        label: "City",
        value: employee?.city,
        validators: [FormRequiredValidator()],
        selectFieldController: CityController());

    state.filter(employee?.country);
    city.filter(employee?.province);

    state.addOnChangeListener((newStateSelected) {
      city.changeFilter(newStateSelected);
    });

    country.addOnChangeListener((newCountrySelected) {
      state.changeFilter(newCountrySelected);
    });

    FormBoolItem rememberMe = FormBoolItem(label: "Remember Me");

    btnSubmit = FormButton(
        label: "Ok",
        onTap: (context) {
          if (validate()) {
            onSubmit(context, getEmployee());
          }
        });

    btnCancel = FormButton(
        label: "Cancel",
        onTap: (context) {
          setEmployee(Employee(name: "", password: ""));
          onCancel(context);
        });

    addField("name", name);
    addField("password", password);
    addField("email", email);
    addField("sinceYear", sinceYear);
    addField("salary", salary);
    addField("number", number);
    addField("percentage", percentage);
    addField("birthday", birthday);
    addField("lastPost", lastPost);
    addField("startTime", startTime);
    addField("country", country);
    addField("province", state);
    addField("city", city);
    addField("rememberMe", rememberMe);
  }

  Employee getEmployee() {
    Map<String, dynamic> empMap = buildObject();

    Employee employee = Employee(
        name: empMap["name"] ?? "", password: empMap["password"] ?? "");
    employee.birthday = empMap["birthday"];
    employee.lastPost = empMap["lastPost"];
    employee.email = empMap["email"];
    employee.salary = empMap["salary"];
    employee.number = empMap["number"];
    employee.percentage = empMap["percentage"];
    employee.employeeSinceYear = empMap["sinceYear"];
    employee.startTime = empMap["startTime"];
    employee.rememberMe = empMap["rememberMe"];
    employee.city = empMap["city"];
    employee.province = empMap["province"];
    employee.country = empMap["country"];
    return employee;
  }

  void setEmployee(Employee employee) {
    setItemValue("name", employee.name);
    setItemValue("password", employee.password);
    setItemValue("email", employee.email);
    setItemValue("salary", employee.salary);
    setItemValue("number", employee.number);
    setItemValue("percentage", employee.percentage);
    setItemValue("birthday", employee.birthday);
    setItemValue("sinceYear", employee.employeeSinceYear);
    setItemValue("lastPost", employee.lastPost);
    setItemValue("startTime", employee.startTime);
    setItemValue("country", employee.country);
    setItemValue("province", employee.province);
    setItemValue("city", employee.city);
    setItemValue("rememberMe", employee.rememberMe);
  }

  FormItemStyle getInputStyle() {
    return FormItemStyle(
        labelAlign: TextAlign.start,
        labelPosition: FieldLabelPosition.borderTop,
        labelSize: 6,
        labelStyle: const TextStyle(
            fontWeight: FontWeight.w400, color: Colors.black54, fontSize: 18),
        inputTextAlign: TextAlign.left,
        inputStyle: const TextStyle(
            fontWeight: FontWeight.w400, color: Colors.black87, fontSize: 18),
        errorInputStyle: const TextStyle(
            fontWeight: FontWeight.w400, color: Colors.red, fontSize: 18),
        fillColor: Colors.white);
  }

  FormItemStyle getPasswordInputStyle() {
    return FormItemStyle(
        labelAlign: TextAlign.start,
        labelPosition: FieldLabelPosition.inside,
        labelSize: 6,
        labelStyle: const TextStyle(
            fontWeight: FontWeight.w400, color: Colors.black54, fontSize: 18),
        inputTextAlign: TextAlign.left,
        inputStyle: const TextStyle(
            fontWeight: FontWeight.w400, color: Colors.black87, fontSize: 18),
        errorInputStyle: const TextStyle(
            fontWeight: FontWeight.w400, color: Colors.red, fontSize: 18),
        fillColor: Colors.white,
        hideText: true);
  }
}
