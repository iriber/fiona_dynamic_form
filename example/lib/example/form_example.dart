import 'package:fiona_dynamic_form/src/model/form_text_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_text_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fiona_dynamic_form/src/model/dynamic_form.dart';


class FormExample  extends StatelessWidget{

  late DynamicForm form;

  FormExample({super.key}){
    form = DynamicForm();

    FormTextItem email = FormTextItem(label: "Email");
    FormTextItem password = FormTextItem(label: "Password");

    form.addField("email", email);
    form.addField("password", password);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.empty(growable: true);

    children.add(Container(
        padding: const EdgeInsets.all(10),
        child: form.getItem("email")?.draw(context),
      ));

    children.add(Container(
      padding: const EdgeInsets.all(10),
      child: form.getItem("password")?.draw(context),
    ));

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