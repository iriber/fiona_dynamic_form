import 'package:fiona_dynamic_form/src/model/form_text_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_item_widget.dart';
import 'package:flutter/material.dart';

enum FieldLabelPosition { inside, left, top}

class FormTextItemWidget extends FormItemWidget {

  FormTextItem formTextItem;
  TextEditingController controller = TextEditingController();

  FormTextItemWidget({super.key,
    required this.formTextItem});

  @override
  State<FormTextItemWidget> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextItemWidget> {

  String? error;


  @override
  void initState(){
    super.initState();

    widget.controller.text = widget.formTextItem.initialValue??"";

    widget.controller.addListener(() {

      widget.formTextItem.setValue(widget.controller.text);

    });



  }

  @override
  Widget build(BuildContext context) {

    widget.formTextItem.onError = ((messages){
      setState(() {
        String msg = "";
        for (var element in messages) {
          msg += " $element";
        }

        error = msg;
      });
    });
    widget.formTextItem.addOnChangeListener ((value){
      setState(() {
        error = "";
      });
    });

    Widget body;
    switch(widget.formTextItem.formItemStyle?.labelPosition){

      case FieldLabelPosition.inside:
        body = buildInput(context);
      case FieldLabelPosition.left:
        body = buildLabelLeft(context);
      case FieldLabelPosition.top:
        body = buildLabelTop(context);
      case null:
        body = buildInput(context);
    }
    return body;
  }

  Widget buildLabelTop(BuildContext context) {
    bool hasError = (error??"").isNotEmpty;
    TextStyle? style = widget.formTextItem.formItemStyle?.labelStyle;
    if(hasError){
      style = widget.formTextItem.formItemStyle?.errorLabelStyle;
    }
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.formTextItem.label, style: style, textAlign: widget.formTextItem.formItemStyle?.labelAlign,),
        const SizedBox(height: 8,),
        buildInput(context)
      ],
    );
  }
  Widget buildLabelLeft(BuildContext context) {

    bool hasError = (error??"").isNotEmpty;
    TextStyle? style = widget.formTextItem.formItemStyle?.labelStyle;
    if(hasError){
      style = widget.formTextItem.formItemStyle?.errorLabelStyle;
    }

    int labelSize = widget.formTextItem.formItemStyle?.labelSize??1;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: labelSize,
          child:
          Padding(padding: const EdgeInsets.only(right:8), child:
          Text(widget.formTextItem.label, style: style,textAlign: widget.formTextItem.formItemStyle?.labelAlign,)),

        ),
        Expanded( flex:(10-labelSize),child: buildInput(context, hideLabel:true))
      ],
    );
  }

  Widget buildInput(BuildContext context, {bool hideLabel=false}) {

    bool hasError = (error??"").isNotEmpty;

    return TextFormField(
      textAlign: widget.formTextItem.formItemStyle?.inputTextAlign??TextAlign.start,
      style: widget.formTextItem.formItemStyle?.inputStyle,
      obscureText: widget.formTextItem.formItemStyle?.hideText??false,
      keyboardType: widget.formTextItem.inputType,
      inputFormatters: widget.formTextItem.inputFormatters,
      enabled: widget.formTextItem.formItemStyle?.enabled,
      controller: widget.controller,
      initialValue: widget.formTextItem.initialValue,
      decoration: InputDecoration(
          prefixIcon: widget.formTextItem.formItemStyle?.prefixIcon,
          filled: true,
          fillColor: widget.formTextItem.formItemStyle?.fillColor??Colors.white30,
          contentPadding: const EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.formTextItem.formItemStyle?.focusedBorderColor??Colors.black87, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.formTextItem.formItemStyle?.borderColor??Colors.black54,
                width: 1.0),
          ),
          labelStyle: widget.formTextItem.formItemStyle?.labelStyle,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: const OutlineInputBorder(),
          prefix: const VerticalDivider(width: 10,),
          labelText:  (hideLabel)?null: "  ${widget.formTextItem.label}",
          errorBorder: hasError?OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.formTextItem.formItemStyle?.errorBorderColor??Colors.red,
                width: 1.0),
          ):null,
          errorText: hasError?error:null,
          errorStyle: widget.formTextItem.formItemStyle?.errorInputStyle

      ),
    );
  }

}