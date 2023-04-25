import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final Function(String?) onSaved;
  final Function(String?) validator;
  final String? initialValue;
  final bool? enabled;

  const CustomTextFormField(
      {required this.hintText,
      required this.prefixIcon,
      required this.onSaved,
      required this.validator,
      this.initialValue,
      this.enabled});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
/// This is the build method of a stateful widget called `CustomTextFormField`. It returns a `Container`
/// widget that contains a `SizedBox` widget with a width of 250 and a `TextFormField` widget. The
/// `TextFormField` widget has various properties such as `decoration`, `validator`, `obscureText`,
/// `onSaved`, `enabled`, and `initialValue` that are passed as parameters to the widget. These
/// properties are used to customize the appearance and behavior of the `TextFormField`. The `validator`
/// property is a function that takes a value and returns an error message if the value is invalid,
/// otherwise it returns null. The `onSaved` property is a function that is called when the form is
/// saved and it takes the value of the `TextFormField` as a parameter. The `enabled` property is used
/// to enable or disable the `TextFormField`. The `initialValue` property is used to set the initial
/// value of the `TextFormField`.
    return Container(
      height: 100,
      child: SizedBox(
        width: 250,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Icon(widget.prefixIcon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (value) {
            final errorMessage = widget.validator(value);
            return errorMessage == null ? null : errorMessage.toString();
          },
          obscureText: widget.hintText == "password",
          onSaved: widget.onSaved,
          enabled: widget.enabled,
          initialValue: widget.initialValue,
        ),
      ),
    );
  }
}
