import 'package:fiona_dynamic_form/src/model/fiona_dynamic_form.dart';
import 'package:flutter/cupertino.dart';

/// This class represents an form item widget.
class DynamicFormWidget extends StatelessWidget {
  final FionaDynamicForm form;

  const DynamicFormWidget({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.empty(growable: true);

    form.items?.forEach((key, item) {
      children.add(Container(
        padding: const EdgeInsets.all(10),
        child: item.draw(context),
      ));
    });

    Widget? btnSubmit = form.btnSubmit?.draw(context);
    Widget? btnCancel = form.btnCancel?.draw(context);

    int okFlex = 5 + (btnCancel == null ? 5 : 0);
    int cancelFlex = 5 + (btnSubmit == null ? 5 : 0);
    if (btnSubmit != null || btnCancel != null) {
      children.add(Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: okFlex, child: btnSubmit ?? const SizedBox.shrink()),
            if (btnCancel != null) Expanded(flex: cancelFlex, child: btnCancel),
          ],
        ),
      ));
    }

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
