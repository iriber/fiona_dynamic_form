import 'package:fiona_dynamic_form/src/model/form_select_item.dart';
import 'package:fiona_dynamic_form/src/widgets/form_item_widget.dart';
import 'package:flutter/material.dart';

enum FieldLabelPosition { inside, left, top}

class FormSelectItemWidget extends FormItemWidget {

  FormSelectItem formItem;

  FormSelectItemWidget({super.key,
    required this.formItem});

  @override
  State<FormSelectItemWidget> createState() => _FormSelectItemWidgetState();
}


class _FormSelectItemWidgetState extends State<FormSelectItemWidget> {

  String? error;
  List items= List.empty(growable: true);
  dynamic selectedValue;
  TextEditingController controller = TextEditingController();

  @override
  void initState(){
    super.initState();

    if(widget.formItem.fillAllItems && items.isEmpty){

      widget.formItem.selectFieldController.findAll().then((results){
        setState(() {
          items = results;
        });
      });

    }

    widget.formItem.onError = ((messages){
      setState(() {
        String msg = "";
        for (var element in messages) {
          msg += " $element";
        }

        error = msg;
      });
    });
    widget.formItem.addOnChangeListener((value){
      setState(() {
        error = "";
      });
    });

    widget.formItem.onFilterChange = ((value){
      widget.formItem.selectFieldController.findAll().then((results){
        setState(() {
          items = results;
        });
      });

    });


  }

  @override
  Widget build(BuildContext context) {


    if(widget.formItem.enableSearch){
      return buildSearchEnabled(context);
    }else{
      return buildSearchDisabled(context);
    }


  }

  Widget buildSearchDisabled(BuildContext context) {
    bool hasError = (error??"").isNotEmpty;

    return InputDecorator(
        decoration: InputDecoration(
            prefixText: "    ",
            prefixIcon: widget.formItem.formItemStyle?.prefixIcon,
            //errorText: error,
            filled: true,
            fillColor: widget.formItem.formItemStyle?.fillColor??Colors.white30,
            contentPadding: const EdgeInsets.only(right: 0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.formItem.formItemStyle?.focusedBorderColor??Colors.black87, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.formItem.formItemStyle?.borderColor??Colors.black54,
                  width: 1.0),
            ),
            labelStyle: widget.formItem.formItemStyle?.labelStyle,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: const OutlineInputBorder(),
            errorBorder: hasError?OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.formItem.formItemStyle?.errorBorderColor??Colors.red,
                  width: 1.0),
            ):null,
            errorText: hasError?error:null,
            errorStyle: widget.formItem.formItemStyle?.errorInputStyle

        ),
        isEmpty: selectedValue == null,
        child: DropdownButtonHideUnderline(
            child:DropdownButton<dynamic>(
              style: widget.formItem.formItemStyle?.inputStyle,
              //icon: widget.prefixIcon??widget.prefixIcon,
              value: widget.formItem.selectFieldController.selected,
              hint: Text( "  ${widget.formItem.label}" ),
              items: items.map((dynamic option) {
                return DropdownMenuItem<dynamic>(
                  value: option,
                  child: Text(widget.formItem.selectFieldController.getItemLabel(option)),
                );
              }).toList(),
              onChanged: (dynamic? newValue) {
                if(newValue==null){
                  widget.formItem.selectFieldController.setTextNotFound(controller?.text??"");
                }else{
                  widget.formItem.selectFieldController.setSelected(newValue);
                }
                setState(() {
                  selectedValue = newValue;
                  widget.formItem.setValue(selectedValue);
                });

              },
              isExpanded: true, // Para que ocupe todo el ancho
            )
        )


    );



  }

  Widget buildSearchEnabled(BuildContext context) {

    if(items.isEmpty && widget.formItem.selectFieldController.selected!=null){
      items.add(widget.formItem.selectFieldController.selected);
    }
    if(controller==null ){
      controller = TextEditingController();
      controller?.addListener((){
        String textToFind = controller?.text??"";

        widget.formItem.selectFieldController.findItems(textToFind).then((results){
          if(results.isEmpty){
            widget.formItem.selectFieldController.setTextNotFound(textToFind);
          }
          setState(() {
            items = results;
          });
        });


      });
    }
    return DropdownMenu(
      width: double.infinity,
      //initialSelection: ColorLabel.green,
      controller: widget.formItem.enableSearch?controller:null,
      // requestFocusOnTap is enabled/disabled by platforms when it is null.
      // On mobile platforms, this is false by default. Setting this to true will
      // trigger focus request on the text field and virtual keyboard will appear
      // afterward. On desktop platforms however, this defaults to true.
      requestFocusOnTap: true,
      label:  Text(widget.formItem.label),
      initialSelection: widget.formItem.selectFieldController.selected,
      onSelected: (dynamic selected){
        if(selected==null){
          widget.formItem.selectFieldController.setTextNotFound(controller?.text??"");
        }else{
          widget.formItem.selectFieldController.setSelected(selected);
        }
      },
      dropdownMenuEntries: items
          .map<DropdownMenuEntry>(
              ( item) {
            return DropdownMenuEntry(
              value: item,
              label: widget.formItem.selectFieldController.getItemLabel(item),
              enabled: true,
            );
          }).toList(),
    );

  }

}