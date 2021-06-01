import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveHaiserDateField extends ReactiveFormField<DateTime, String> {
  ReactiveHaiserDateField({
    @required String formControlName,
    InputDecoration decoration,
    bool showClearIcon = true,
    Widget clearIcon = const Icon(Icons.clear),
    ControlValueAccessor<DateTime, String> valueAccessor,
    TextStyle style,
  }) : super(
          formControlName: formControlName,
          valueAccessor: valueAccessor ??
              DateTimeValueAccessor(
                dateTimeFormat: DateFormat('yyyy/MM/dd'),
              ),
          builder: (field) {
            Widget suffixIcon = decoration?.suffixIcon;

            final isEmptyValue =
                field.value == null || field.value?.isEmpty == true;

            if (showClearIcon && !isEmptyValue) {
              suffixIcon = InkWell(
                borderRadius: BorderRadius.circular(25),
                child: clearIcon,
                onTap: () {
                  field.control.markAsTouched();
                  field.didChange(null);
                },
              );
            }

            final InputDecoration effectiveDecoration =
                (decoration ?? const InputDecoration())
                    .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                    .copyWith(suffixIcon: suffixIcon);

            return GestureDetector(
              onTap: () {
                selectBirthday(
                    field,
                    DateTimeValueAccessor(
                        dateTimeFormat: DateFormat('yyyy/MM/dd')));
              },
              child: InputDecorator(
                decoration: effectiveDecoration.copyWith(
                  errorText: field.errorText,
                  enabled: field.control.enabled,
                ),
                isEmpty: isEmptyValue && effectiveDecoration.hintText == null,
                child: Text(
                  field.value ?? '',
                  style:
                      Theme.of(field.context).textTheme.subtitle1?.merge(style),
                ),
              ),
            );
          },
        );

  @override
  ReactiveFormFieldState<DateTime, String> createState() =>
      ReactiveFormFieldState<DateTime, String>();

  static void selectBirthday(ReactiveFormFieldState<DateTime, String> field,
      DateTimeValueAccessor valueAccessor) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          customColumnType: [0, 1, 2],
          minValue: DateTime(1960),
          maxValue: DateTime.now(),
          value: field.control.value,
          daySuffix: "日",
          isNumberMonth: true,
          monthSuffix: "月",
          yearSuffix: "年",
        ),
        title: Text("出生日期"),
        cancelText: "取消",
        confirmText: "确定",
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          field.didChange(valueAccessor.modelToViewValue(
              (picker.adapter as DateTimePickerAdapter).value));
          field.control.markAsTouched();
        }).showDialog(field.context);
  }
}
