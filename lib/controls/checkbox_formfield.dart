import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    bool initValue,
  }) : super(
          builder: CheckboxFormField.buildWidget,
          initialValue: initValue,
        );

  static Widget buildWidget(FormFieldState<bool> field) {
    return InputDecorator(
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.ac_unit_outlined),  
               
          ),
      child: Container(
        height: 22,
          alignment: Alignment.centerRight,
          child: Checkbox(
            onChanged: (bool value) {
              field.didChange(value);
            },
            value: field.value,
          )),
    );
  }
}
