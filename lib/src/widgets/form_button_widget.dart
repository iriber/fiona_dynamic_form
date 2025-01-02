import 'package:fiona_dynamic_form/src/model/form_button.dart';
import 'package:flutter/material.dart';

class FormButtonWidget extends StatelessWidget {
  final FormButton formButton;

  const FormButtonWidget({super.key, required this.formButton});

  @override
  Widget build(BuildContext context) {
    String label = formButton.label;
    String txtLabel = (formButton.formButtonStyle?.toUppercase ?? false)
        ? label.toUpperCase()
        : label;

    return Container(
        width: formButton.formButtonStyle?.width ??
            MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
          style: formButton.formButtonStyle?.buttonStyle,
          child: formButton.formButtonStyle?.iconLabel != null
              ? Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: formButton.formButtonStyle?.iconLabel,
                    ),
                    Text(
                      txtLabel,
                      style: formButton.formButtonStyle?.labelStyle,
                      maxLines: formButton.formButtonStyle?.maxLines ?? 1,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                  ],
                )
              : Text(
                  txtLabel,
                  style: formButton.formButtonStyle?.labelStyle,
                  maxLines: formButton.formButtonStyle?.maxLines ?? 1,
                  textAlign: TextAlign.center,
                ),
          onPressed: () {
            formButton.onTap(context);
          },
        ));
  }
}
